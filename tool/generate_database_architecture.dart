import 'dart:io';

import 'package:yaml/yaml.dart';

const tableWidth = 330.0;
const leftX = 40.0;
const rightX = 620.0;
const topY = 35.0;
const rowHeight = 44.0;
const headerHeight = 52.0;
const tableGap = 70.0;

void main(List<String> arguments) {
  final root = Directory.current.path;
  final schemaFile = arguments.isNotEmpty
      ? File(arguments.first)
      : File('$root/assets/database_schema.yaml');
  final outputFile = arguments.length > 1
      ? File(arguments[1])
      : File('$root/assets/images/database_schema/database_architecture.svg');

  if (!schemaFile.existsSync()) {
    stderr.writeln('Schema not found: ${schemaFile.path}');
    exitCode = 1;
    return;
  }

  final document = loadYaml(schemaFile.readAsStringSync()) as YamlMap;
  final tables = (document['tables'] as YamlList)
      .map((value) => TableDefinition.fromYaml(value as YamlMap))
      .toList();
  final relationships = (document['relationships'] as YamlList)
      .map((value) => Relationship.fromYaml(value as YamlMap))
      .toList();

  final layout = _layoutTables(tables);
  final svg = _buildSvg(layout, relationships);

  outputFile.parent.createSync(recursive: true);
  outputFile.writeAsStringSync(svg);
  stdout.writeln('Generated ${outputFile.path}');
}

class ColumnDefinition {
  ColumnDefinition({
    required this.name,
    required this.type,
    this.key,
  });

  final String name;
  final String type;
  final String? key;

  factory ColumnDefinition.fromYaml(YamlMap yaml) {
    return ColumnDefinition(
      name: yaml['name'] as String,
      type: yaml['type'] as String,
      key: yaml['key'] as String?,
    );
  }
}

class TableDefinition {
  TableDefinition({
    required this.name,
    required this.side,
    required this.columns,
  });

  final String name;
  final String side;
  final List<ColumnDefinition> columns;

  factory TableDefinition.fromYaml(YamlMap yaml) {
    return TableDefinition(
      name: yaml['name'] as String,
      side: (yaml['side'] as String?) ?? 'left',
      columns: (yaml['columns'] as YamlList)
          .map((value) => ColumnDefinition.fromYaml(value as YamlMap))
          .toList(),
    );
  }
}

class Relationship {
  Relationship({required this.from, required this.to});

  final String from;
  final String to;

  factory Relationship.fromYaml(YamlMap yaml) {
    return Relationship(
      from: yaml['from'] as String,
      to: yaml['to'] as String,
    );
  }
}

class PositionedTable {
  PositionedTable({
    required this.definition,
    required this.x,
    required this.y,
  });

  final TableDefinition definition;
  final double x;
  final double y;

  double get width => tableWidth;
  double get height =>
      headerHeight + definition.columns.length * rowHeight;

  double rowCenter(int index) =>
      y + headerHeight + rowHeight * index + rowHeight / 2;
}

class TableLayout {
  TableLayout({required this.tables, required this.width, required this.height});

  final List<PositionedTable> tables;
  final double width;
  final double height;
}

TableLayout _layoutTables(List<TableDefinition> tables) {
  final left = tables.where((table) => table.side == 'left').toList();
  final right = tables.where((table) => table.side == 'right').toList();
  final positioned = <PositionedTable>[];

  double leftY = topY;
  for (final table in left) {
    final height = headerHeight + table.columns.length * rowHeight;
    positioned.add(PositionedTable(definition: table, x: leftX, y: leftY));
    leftY += height + tableGap;
  }

  double rightY = topY;
  for (final table in right) {
    final height = headerHeight + table.columns.length * rowHeight;
    positioned.add(PositionedTable(definition: table, x: rightX, y: rightY));
    rightY += height + tableGap;
  }

  final maxLeftY = leftY - tableGap;
  final maxRightY = rightY - tableGap;
  final height = <double>[maxLeftY, maxRightY, 760].reduce((a, b) => a > b ? a : b);
  return TableLayout(tables: positioned, width: 1000, height: height);
}

String _buildSvg(
  TableLayout layout,
  List<Relationship> relationships,
) {
  final buffer = StringBuffer();
  buffer.writeln(
    '<svg xmlns="http://www.w3.org/2000/svg" '
    'width="${layout.width.toInt()}" height="${layout.height.toInt()}" '
    'viewBox="0 0 ${layout.width.toInt()} ${layout.height.toInt()}">',
  );
  buffer.writeln('''  <style>
    .background { fill: #f7f9fc; }
    .table { fill: #ffffff; stroke: #4a9b9b; stroke-width: 2; }
    .header { fill: #4a9b9b; }
    .separator { stroke: #c9d8dc; stroke-width: 1; }
    .connection { fill: none; stroke: #4a9b9b; stroke-width: 3; }
    .title { fill: #ffffff; font: 700 20px Arial, sans-serif; }
    .field { fill: #1f2328; font: 16px Arial, sans-serif; }
    .type { fill: #66757a; font: 15px monospace; }
    .key { fill: #4a9b9b; font: 700 13px Arial, sans-serif; }
  </style>''');
  buffer.writeln(
    '  <rect class="background" x="0" y="0" '
    'width="${layout.width.toInt()}" height="${layout.height.toInt()}" rx="8"/>',
  );

  for (final table in layout.tables) {
    _writeTable(buffer, table);
  }

  for (final relationship in relationships) {
    final source = _findColumn(layout.tables, relationship.from);
    final target = _findColumn(layout.tables, relationship.to);
    if (source == null || target == null) {
      stderr.writeln(
        'Unknown relationship column: ${relationship.from} -> ${relationship.to}',
      );
      continue;
    }

    final sourceX = source.table.x + tableWidth;
    final targetX = target.table.x;
    final middleX = source.table.x < target.table.x
        ? (sourceX + targetX) / 2
        : (targetX + tableWidth + source.table.x) / 2;
    buffer.writeln(
      '  <path class="connection" d="M${_n(sourceX)} ${_n(source.rowY)} '
      'H${_n(middleX)} V${_n(target.rowY)} H${_n(targetX)}"/>',
    );
  }

  buffer.writeln('</svg>');
  return buffer.toString().trimRight();
}

void _writeTable(StringBuffer buffer, PositionedTable table) {
  final definition = table.definition;
  final x = table.x;
  final y = table.y;
  final height = table.height;
  final bottom = y + height;

  buffer.writeln(
    '  <g aria-label="${_escape(definition.name)} table">',
  );
  buffer.writeln(
    '    <rect class="table" x="${_n(x)}" y="${_n(y)}" '
    'width="${tableWidth.toInt()}" height="${height.toInt()}" rx="6"/>',
  );
  buffer.writeln(
    '    <rect class="header" x="${_n(x)}" y="${_n(y)}" '
    'width="${tableWidth.toInt()}" height="${headerHeight.toInt()}" rx="6"/>',
  );
  buffer.writeln(
    '    <text class="title" x="${_n(x + 20)}" y="${_n(y + 33)}">'
    '${_escape(definition.name)}</text>',
  );

  for (var index = 0; index <= definition.columns.length; index++) {
    final separatorY = y + headerHeight + index * rowHeight;
    if (index == 0 || separatorY <= bottom) {
      buffer.writeln(
        '    <line class="separator" x1="${_n(x)}" y1="${_n(separatorY)}" '
        'x2="${_n(x + tableWidth)}" y2="${_n(separatorY)}"/>',
      );
    }
  }

  for (var index = 0; index < definition.columns.length; index++) {
    final column = definition.columns[index];
    final rowY = table.rowCenter(index);
    if (column.key != null) {
      buffer.writeln(
        '    <text class="key" x="${_n(x + 15)}" y="${_n(rowY + 5)}">'
        '${_escape(column.key!)}</text>',
      );
    }
    buffer.writeln(
      '    <text class="field" x="${_n(x + 55)}" y="${_n(rowY + 5)}">'
      '${_escape(column.name)}</text>',
    );
    buffer.writeln(
      '    <text class="type" x="${_n(x + 245)}" y="${_n(rowY + 5)}">'
      '${_escape(column.type)}</text>',
    );
  }
  buffer.writeln('  </g>');
}

class LocatedColumn {
  LocatedColumn({
    required this.table,
    required this.rowY,
  });

  final PositionedTable table;
  final double rowY;
}

LocatedColumn? _findColumn(
  List<PositionedTable> tables,
  String qualifiedName,
) {
  final separator = qualifiedName.lastIndexOf('.');
  if (separator < 0) return null;

  final tableName = qualifiedName.substring(0, separator);
  final columnName = qualifiedName.substring(separator + 1);

  for (final table in tables) {
    if (table.definition.name != tableName) continue;
    for (
      var index = 0;
      index < table.definition.columns.length;
      index++
    ) {
      if (table.definition.columns[index].name == columnName) {
        return LocatedColumn(
          table: table,
          rowY: table.rowCenter(index),
        );
      }
    }
  }
  return null;
}

String _n(double value) => value == value.roundToDouble()
    ? value.toInt().toString()
    : value.toStringAsFixed(1);

String _escape(String value) => value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');
