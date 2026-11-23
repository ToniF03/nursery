import 'dart:io';

import 'package:yaml/yaml.dart';

void main(List<String> arguments) {
  final root = Directory.current.path;
  final specFile = arguments.isNotEmpty
      ? File(arguments.first)
      : File('$root/assets/diagrams.yaml');
  final imageDirectory = arguments.length > 1
      ? Directory(arguments[1])
      : Directory('$root/assets/images/diagrams');

  if (!specFile.existsSync()) {
    stderr.writeln('Diagram specification not found: ${specFile.path}');
    exitCode = 1;
    return;
  }

  final document = loadYaml(specFile.readAsStringSync()) as YamlMap;
  imageDirectory.createSync(recursive: true);

  final useCaseSpec = document['use_cases'] as YamlMap;
  final useCases = (useCaseSpec['use_cases'] as YamlList).cast<String>().toList();
  for (var index = 0; index < useCases.length; index += 6) {
    final end = index + 6 > useCases.length ? useCases.length : index + 6;
    final part = index ~/ 6 + 1;
    final file = File(
      '${imageDirectory.path}/use_case_diagram_$part.svg',
    );
    file.writeAsStringSync(
      _buildUseCaseSvg(useCaseSpec, useCases.sublist(index, end), part),
    );
    stdout.writeln('Generated ${file.path}');
  }

  final classes = (document['classes'] as YamlList)
      .map((value) => _ClassDefinition.fromYaml(value as YamlMap))
      .toList();
  final relationships = (document['class_relationships'] as YamlList)
      .map((value) => _Relationship.fromYaml(value as YamlMap))
      .toList();
  final groups = classes.map((item) => item.group).toSet().toList();

  for (final group in groups) {
    final slug = group.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
    final file = File(
      '${imageDirectory.path}/class_diagram_$slug.svg',
    );
    file.writeAsStringSync(
      _buildClassSvg(group, classes, relationships),
    );
    stdout.writeln('Generated ${file.path}');
  }
}

String _buildUseCaseSvg(
  YamlMap spec,
  List<String> useCases,
  int part,
) {
  const width = 900;
  const height = 1050;
  const left = 45;
  const right = 810;
  const systemX = 170;
  const systemY = 50;
  const systemWidth = 560;
  const systemHeight = 950;

  final positions = <String, _Point>{};
  final buffer = StringBuffer();
  buffer.writeln(
    '<svg xmlns="http://www.w3.org/2000/svg" width="$width" height="$height" '
    'viewBox="0 0 $width $height">',
  );
  buffer.writeln(_svgStyle());
  buffer.writeln(
    '  <rect class="background" x="0" y="0" width="$width" '
    'height="$height" rx="8"/>',
  );
  buffer.writeln(
    '  <rect class="system" x="$systemX" y="$systemY" '
    'width="$systemWidth" height="$systemHeight" rx="12"/>',
  );

  const caseWidth = 220;
  const caseHeight = 62;
  for (var index = 0; index < useCases.length; index++) {
    final column = index % 2;
    final row = index ~/ 2;
    final x = systemX + 45 + column * 260;
    final y = systemY + 105 + row * 125;
    final point = _Point(
      x + caseWidth / 2,
      y + caseHeight / 2,
    );
    positions[useCases[index]] = point;
    buffer.writeln(
      '  <ellipse class="use-case" cx="${point.x}" cy="${point.y}" '
      'rx="${caseWidth / 2}" ry="${caseHeight / 2}"/>',
    );
    buffer.writeln(
      '  <text class="use-case-text" x="${point.x}" '
      'y="${point.y + 5}" text-anchor="middle">'
      '${_escape(useCases[index])}</text>',
    );
  }

  buffer.writeln(_actorSvg(spec['actor'] as String, left, 430));
  final externalActors =
      (spec['external_actors'] as YamlList).cast<String>().toList();
  for (var index = 0; index < externalActors.length; index++) {
    buffer.writeln(
      _actorSvg(externalActors[index], right, 280 + index * 260),
    );
  }

  for (final item in (spec['actor_links'] as YamlList).cast<String>()) {
    final parts = item.split(' -> ');
    if (parts.length != 2 || !positions.containsKey(parts[1])) continue;
    final target = positions[parts[1]]!;
    final targetLeft = (target.x - caseWidth / 2).toInt();
    buffer.writeln(
      '  <path class="actor-line" d="M73 430 H120 '
      'V${target.y.toInt()} H$targetLeft"/>',
    );
  }

  for (var index = 0; index < externalActors.length; index++) {
    final actorName = externalActors[index];
    final actorY = 280 + index * 260;
    for (final item
        in (spec['external_links'] as YamlList).cast<String>()) {
      final parts = item.split(' -> ');
      if (parts.length != 2 ||
          parts[1] != actorName ||
          !positions.containsKey(parts[0])) {
        continue;
      }
      final source = positions[parts[0]]!;
      final sourceRight = (source.x + caseWidth / 2).toInt();
      buffer.writeln(
        '  <path class="actor-line" d="M$sourceRight ${source.y.toInt()} '
        'H760 V$actorY H782"/>',
      );
    }
  }

  for (final item in (spec['includes'] as YamlList).cast<String>()) {
    final parts = item.split(' -> ');
    if (parts.length != 2 ||
        !positions.containsKey(parts[0]) ||
        !positions.containsKey(parts[1])) {
      continue;
    }
    final source = positions[parts[0]]!;
    final target = positions[parts[1]]!;
    final sameRow = (source.y - target.y).abs() < 20;
    if (sameRow) {
      if (source.x < target.x) {
        final sourceRight = (source.x + caseWidth / 2).toInt();
        final targetLeft = (target.x - caseWidth / 2).toInt();
        buffer.writeln(
          '  <path class="include-line" d="M$sourceRight ${source.y.toInt()} '
          'H$targetLeft"/>',
        );
      } else {
        final sourceLeft = (source.x - caseWidth / 2).toInt();
        final targetRight = (target.x + caseWidth / 2).toInt();
        buffer.writeln(
          '  <path class="include-line" d="M$sourceLeft ${source.y.toInt()} '
          'H$targetRight"/>',
        );
      }
    } else {
      final laneY = ((source.y + target.y) / 2).toInt();
      final sourceEdge = source.y < target.y
          ? (source.y + caseHeight / 2).toInt()
          : (source.y - caseHeight / 2).toInt();
      final targetEdge = source.y < target.y
          ? (target.y - caseHeight / 2).toInt()
          : (target.y + caseHeight / 2).toInt();
      buffer.writeln(
        '  <path class="include-line" d="M${source.x.toInt()} $sourceEdge '
        'V$laneY H${target.x.toInt()} V$targetEdge"/>',
      );
    }
  }

  buffer.writeln('</svg>');
  return buffer.toString();
}

String _actorSvg(String name, int x, int y) {
  final lines = _splitLabel(name);
  final buffer = StringBuffer();
  buffer.writeln('  <circle class="actor" cx="$x" cy="${y - 55}" r="18"/>');
  buffer.writeln(
    '  <line class="actor" x1="$x" y1="${y - 37}" x2="$x" y2="${y + 20}"/>',
  );
  buffer.writeln(
    '  <line class="actor" x1="${x - 28}" y1="${y - 18}" '
    'x2="${x + 28}" y2="${y - 18}"/>',
  );
  buffer.writeln(
    '  <line class="actor" x1="$x" y1="${y + 20}" '
    'x2="${x - 20}" y2="${y + 48}"/>',
  );
  buffer.writeln(
    '  <line class="actor" x1="$x" y1="${y + 20}" '
    'x2="${x + 20}" y2="${y + 48}"/>',
  );
  for (var index = 0; index < lines.length; index++) {
    buffer.writeln(
      '  <text class="actor-text" x="$x" y="${y + 72 + index * 18}" '
      'text-anchor="middle">${_escape(lines[index])}</text>',
    );
  }
  return buffer.toString();
}

List<String> _splitLabel(String text) {
  final words = text.split(' ');
  final lines = <String>[];
  for (var index = 0; index < words.length; index += 3) {
    lines.add(words.skip(index).take(3).join(' '));
  }
  return lines;
}

String _buildClassSvg(
  String group,
  List<_ClassDefinition> allClasses,
  List<_Relationship> allRelationships,
) {
  const width = 900;
  const cardWidth = 260;
  const height = 1050;
  const left = 50;
  const top = 80;

  final classes =
      allClasses.where((item) => item.group == group).toList();
  final positions = <String, _Rect>{};
  final buffer = StringBuffer();
  buffer.writeln(
    '<svg xmlns="http://www.w3.org/2000/svg" width="$width" '
    'height="$height" viewBox="0 0 $width $height">',
  );
  buffer.writeln(_svgStyle());
  buffer.writeln(
    '  <rect class="background" x="0" y="0" '
    'width="$width" height="$height" rx="8"/>',
  );

  for (var index = 0; index < classes.length; index++) {
    final column = index % 3;
    final row = index ~/ 3;
    final x = left + column * 270;
    final y = top + row * 240;
    final cardHeight = _classCardHeight(classes[index]);
    positions[classes[index].name] =
        _Rect(x.toDouble(), y.toDouble(), cardWidth.toDouble(), cardHeight);
    _writeClassCard(buffer, classes[index], x, y, cardWidth, cardHeight);
  }

  for (final relationship in allRelationships) {
    if (!positions.containsKey(relationship.from) ||
        !positions.containsKey(relationship.to)) {
      continue;
    }
    _writeRelationship(
      buffer,
      positions[relationship.from]!,
      positions[relationship.to]!,
      relationship.label,
      positions.values.toList(),
    );
  }

  buffer.writeln('</svg>');
  return buffer.toString();
}

double _classCardHeight(_ClassDefinition item) {
  final lineCount = item.fields.length + item.methods.length;
  return 74 + lineCount * 22;
}

void _writeClassCard(
  StringBuffer buffer,
  _ClassDefinition item,
  int x,
  int y,
  int width,
  double height,
) {
  buffer.writeln(
    '  <rect class="class-card" x="$x" y="$y" '
    'width="$width" height="${height.toInt()}"/>',
  );
  buffer.writeln(
    '  <rect class="class-header" x="$x" y="$y" '
    'width="$width" height="48"/>',
  );
  buffer.writeln(
    '  <text class="class-title" x="${x + width / 2}" y="${y + 30}" '
    'text-anchor="middle">'
    '${item.abstract ? '&lt;&lt;abstract&gt;&gt; ' : ''}'
    '${_escape(item.name)}</text>',
  );

  var lineY = y + 70;
  for (final field in item.fields) {
    buffer.writeln(
      '  <text class="class-field" x="${x + 14}" y="$lineY">'
      '+ ${_escape(field)}</text>',
    );
    lineY += 22;
  }
  if (item.fields.isNotEmpty && item.methods.isNotEmpty) {
    buffer.writeln(
      '  <line class="class-divider" x1="$x" y1="$lineY" '
      'x2="${x + width}" y2="$lineY"/>',
    );
    lineY += 12;
  }
  for (final method in item.methods) {
    buffer.writeln(
      '  <text class="class-method" x="${x + 14}" y="$lineY">'
      '+ ${_escape(method)}</text>',
    );
    lineY += 22;
  }
}

void _writeRelationship(
  StringBuffer buffer,
  _Rect from,
  _Rect to,
  String label,
  List<_Rect> obstacles,
) {
  final sameRow = (from.y - to.y).abs() < 20;
  late int startX;
  late int startY;
  late int endX;
  late int endY;
  late int labelX;
  late int labelY;

  if (sameRow) {
    final startRight = from.x < to.x
        ? (from.x + from.width).toInt()
        : from.x.toInt();
    final endLeft = from.x < to.x
        ? to.x.toInt()
        : (to.x + to.width).toInt();
    final segmentStart = startRight < endLeft ? startRight : endLeft;
    final segmentEnd = startRight < endLeft ? endLeft : startRight;
    final lineY = (from.y + 24).toInt();
    var isBlocked = false;
    for (final obstacle in obstacles) {
      if (identical(obstacle, from) || identical(obstacle, to)) continue;
      final obstacleLeft = obstacle.x.toInt();
      final obstacleRight = (obstacle.x + obstacle.width).toInt();
      final crossesX =
          obstacleRight > segmentStart && obstacleLeft < segmentEnd;
      final crossesY =
          lineY >= obstacle.y && lineY <= obstacle.y + obstacle.height;
      if (crossesX && crossesY) {
        isBlocked = true;
        break;
      }
    }

    if (isBlocked) {
      startX = startRight;
      endX = endLeft;
      startY = lineY;
      endY = (to.y + 24).toInt();
      final laneY = ([
        from.y + from.height,
        to.y + to.height,
        ...obstacles
            .where((obstacle) =>
                obstacle.x < segmentEnd &&
                obstacle.x + obstacle.width > segmentStart)
            .map((obstacle) => obstacle.y + obstacle.height),
      ].reduce((value, element) => value > element ? value : element) +
              24)
          .toInt();
      labelX = ((startX + endX) / 2).toInt();
      labelY = laneY - 8;
      buffer.writeln(
        '  <path class="relation" d="M$startX $startY '
        'V$laneY H$endX V$endY"/>',
      );
      buffer.writeln(
        '  <text class="relation-label" x="$labelX" '
        'y="$labelY">${_escape(label)}</text>',
      );
      return;
    }

    if (from.x < to.x) {
      startX = (from.x + from.width).toInt();
      endX = to.x.toInt();
    } else {
      startX = from.x.toInt();
      endX = (to.x + to.width).toInt();
    }
    startY = (from.y + 24).toInt();
    endY = (to.y + 24).toInt();
    labelX = ((startX + endX) / 2).toInt();
    labelY = startY - 8;

    buffer.writeln(
      '  <path class="relation" d="M$startX $startY H$endX"/>',
    );
  } else {
    startX = (from.x + from.width / 2).toInt();
    endX = (to.x + to.width / 2).toInt();
    if (from.y < to.y) {
      startY = (from.y + from.height).toInt();
      endY = to.y.toInt();
    } else {
      startY = from.y.toInt();
      endY = (to.y + to.height).toInt();
    }
    final laneY = (startY < endY)
        ? ((startY + endY) / 2).toInt()
        : ((startY + endY) / 2).toInt();
    labelX = ((startX + endX) / 2).toInt();
    labelY = laneY - 8;

    final endOffset = endX - 18;
    buffer.writeln(
      '  <path class="relation" d="M$startX $startY '
      'V$laneY H$endOffset V$laneY H$endX V$endY"/>',
    );
  }

  buffer.writeln(
    '  <text class="relation-label" x="$labelX" '
    'y="$labelY">${_escape(label)}</text>',
  );
}

class _ClassDefinition {
  _ClassDefinition({
    required this.name,
    required this.group,
    required this.fields,
    required this.methods,
    required this.abstract,
  });

  final String name;
  final String group;
  final List<String> fields;
  final List<String> methods;
  final bool abstract;

  factory _ClassDefinition.fromYaml(YamlMap yaml) {
    return _ClassDefinition(
      name: yaml['name'] as String,
      group: yaml['group'] as String? ?? 'Other',
      fields: ((yaml['fields'] as YamlList?) ?? YamlList()).cast<String>(),
      methods: ((yaml['methods'] as YamlList?) ?? YamlList()).cast<String>(),
      abstract: yaml['abstract'] as bool? ?? false,
    );
  }
}

class _Relationship {
  _Relationship({
    required this.from,
    required this.to,
    required this.label,
  });

  final String from;
  final String to;
  final String label;

  factory _Relationship.fromYaml(YamlMap yaml) {
    return _Relationship(
      from: yaml['from'] as String,
      to: yaml['to'] as String,
      label: yaml['label'] as String? ?? '',
    );
  }
}

class _Point {
  const _Point(this.x, this.y);
  final double x;
  final double y;
}

class _Rect {
  const _Rect(this.x, this.y, this.width, this.height);
  final double x;
  final double y;
  final double width;
  final double height;
}

String _svgStyle() => '''  <style>
    .background { fill: #f7f9fc; }
    .system { fill: #ffffff; stroke: #4a9b9b; stroke-width: 3; }
    .system-title { fill: #1f2328; font: 700 21px Arial, sans-serif; }
    .use-case { fill: #ffffff; stroke: #4a9b9b; stroke-width: 2; }
    .use-case-text { fill: #1f2328; font: 13px Arial, sans-serif; }
    .actor { fill: #ffffff; stroke: #1f2328; stroke-width: 3; }
    .actor-text { fill: #1f2328; font: 700 13px Arial, sans-serif; }
    .actor-line { fill: none; stroke: #66757a; stroke-width: 2; }
    .include-line { fill: none; stroke: #4a9b9b; stroke-width: 2; stroke-dasharray: 8 6; }
    .group-title { fill: #1f2328; font: 700 22px Arial, sans-serif; }
    .class-card { fill: #ffffff; stroke: #4a9b9b; stroke-width: 2; }
    .class-header { fill: #4a9b9b; }
    .class-title { fill: #ffffff; font: 700 15px Arial, sans-serif; }
    .class-field { fill: #1f2328; font: 12px monospace; }
    .class-method { fill: #365899; font: 12px monospace; }
    .class-divider { stroke: #c9d8dc; stroke-width: 1; }
    .relation { fill: none; stroke: #66757a; stroke-width: 1.5; }
    .relation-label { fill: #66757a; font: 11px Arial, sans-serif; }
  </style>''';

String _escape(String value) => value
    .replaceAll('&', '&amp;')
    .replaceAll('<', '&lt;')
    .replaceAll('>', '&gt;')
    .replaceAll('"', '&quot;');
