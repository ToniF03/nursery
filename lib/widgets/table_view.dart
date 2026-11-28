import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/l10n/app_localizations.dart';

typedef TableCellBuilder<T> = Widget Function(BuildContext context, T row);
typedef TableRowComparator<T> = int Function(T first, T second);

// TODO: Pagination for long tables, with a "View All" button to show the full list.

class TableViewColumn<T> {
  const TableViewColumn({
    required this.label,
    required this.cellBuilder,
    required this.compare,
    this.minWidth = 100,
    this.flex = 1,
    this.alignRight = false,
  });

  final String label;
  final TableCellBuilder<T> cellBuilder;
  final TableRowComparator<T> compare;
  final double minWidth;
  final int flex;
  final bool alignRight;
}

class TableView<T> extends StatefulWidget {
  const TableView({
    super.key,
    this.showAllButton = true,
    required this.title,
    required this.columns,
    required this.rows,
    this.onViewAll,
    this.onRowTap,
    this.emptyState,
  });

  final String title;
  final bool showAllButton;
  final List<TableViewColumn<T>> columns;
  final List<T> rows;
  final VoidCallback? onViewAll;
  final ValueChanged<T>? onRowTap;
  final Widget? emptyState;

  @override
  State<TableView<T>> createState() => _TableViewState<T>();
}

class _TableViewState<T> extends State<TableView<T>> {
  int? _sortColumnIndex;
  bool _ascending = true;

  void _onSort(int columnIndex) {
    setState(() {
      if (_sortColumnIndex == columnIndex) {
        _ascending = !_ascending;
      } else {
        _sortColumnIndex = columnIndex;
        _ascending = true;
      }
    });
  }

  List<T> get _displayRows {
    final rows = List<T>.of(widget.rows);
    final sortColumnIndex = _sortColumnIndex;
    if (sortColumnIndex == null || sortColumnIndex >= widget.columns.length) {
      return rows;
    }

    final compare = widget.columns[sortColumnIndex].compare;
    rows.sort((first, second) {
      final result = compare(first, second);
      return _ascending ? result : -result;
    });
    return rows;
  }

  Widget _buildCell({
    required TableViewColumn<T> column,
    required Widget child,
  }) {
    return Expanded(
      flex: column.flex,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: column.minWidth),
        child: Align(
          alignment: column.alignRight
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: child,
        ),
      ),
    );
  }

  Widget _buildHeaderCell(int index, TableViewColumn<T> column) {
    final isActive = _sortColumnIndex == index;

    return _buildCell(
      column: column,
      child: InkWell(
        onTap: () => _onSort(index),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          child: Row(
            mainAxisAlignment: column.alignRight
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                column.label.toUpperCase(),
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? Colors.black : Colors.black87,
                ),
              ),
              if (isActive) ...[
                const SizedBox(width: 4),
                Icon(
                  _ascending ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, T row) {
    return InkWell(
      onTap: widget.onRowTap == null ? null : () => widget.onRowTap!(row),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            for (
              var columnIndex = 0;
              columnIndex < widget.columns.length;
              columnIndex++
            ) ...[
              if (columnIndex > 0) const SizedBox(width: 16),
              _buildCell(
                column: widget.columns[columnIndex],
                child: widget.columns[columnIndex].cellBuilder(context, row),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rows = _displayRows;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(layoutPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (widget.showAllButton && widget.onViewAll != null)
                  TextButton(
                    onPressed: widget.onViewAll,
                    child: Text(AppLocalizations.of(context)!.viewAll),
                  ),
              ],
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Material(
                          color: const Color(0xFFF1F1F1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                for (
                                  var i = 0;
                                  i < widget.columns.length;
                                  i++
                                ) ...[
                                  if (i > 0) const SizedBox(width: 16),
                                  _buildHeaderCell(i, widget.columns[i]),
                                ],
                              ],
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.white,
                          child: rows.isEmpty
                              ? widget.emptyState ?? const SizedBox.shrink()
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var i = 0; i < rows.length; i++) ...[
                                      if (i > 0)
                                        const Divider(
                                          height: 1,
                                          thickness: 1,
                                          color: Color(0xFFF1F1F1),
                                        ),
                                      _buildRow(context, rows[i]),
                                    ],
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
