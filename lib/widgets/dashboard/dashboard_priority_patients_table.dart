import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/pill.dart';

enum _SortColumn { patient, status, spo2, pulse, temp, lastSync }

class _PatientRowData {
  const _PatientRowData({
    required this.name,
    required this.room,
    required this.status,
    required this.statusPriority,
    required this.statusColor,
    required this.spo2,
    required this.pulse,
    required this.temp,
    required this.lastSyncMinutes,
    required this.lastSyncLabel,
  });

  final String name;
  final String room;
  final String status;
  final int statusPriority;
  final Color statusColor;
  final int spo2;
  final int pulse;
  final double temp;
  final int lastSyncMinutes;
  final String lastSyncLabel;
}

class DashboardPriorityPatientsTable extends StatefulWidget {
  const DashboardPriorityPatientsTable({super.key});

  @override
  State<DashboardPriorityPatientsTable> createState() =>
      _DashboardPriorityPatientsTableState();
}

class _DashboardPriorityPatientsTableState
    extends State<DashboardPriorityPatientsTable> {
  _SortColumn _sortColumn = _SortColumn.status;
  bool _ascending = false;

  final List<_PatientRowData> _patients = [
    const _PatientRowData(
      name: 'John Doe',
      room: 'Room 101',
      status: 'Critical',
      statusPriority: 3,
      statusColor: Colors.red,
      spo2: 92,
      pulse: 110,
      temp: 37.5,
      lastSyncMinutes: 10,
      lastSyncLabel: '10 mins ago',
    ),
    const _PatientRowData(
      name: 'Anna Smith',
      room: 'Room 104',
      status: 'Warning',
      statusPriority: 2,
      statusColor: Colors.orange,
      spo2: 95,
      pulse: 98,
      temp: 38.2,
      lastSyncMinutes: 3,
      lastSyncLabel: '3 mins ago',
    ),
    const _PatientRowData(
      name: 'Max Weber',
      room: 'Room 102',
      status: 'Stable',
      statusPriority: 1,
      statusColor: Colors.green,
      spo2: 98,
      pulse: 74,
      temp: 36.8,
      lastSyncMinutes: 25,
      lastSyncLabel: '25 mins ago',
    ),
  ];

  void _onSort(_SortColumn column) {
    setState(() {
      if (_sortColumn == column) {
        _ascending = !_ascending;
      } else {
        _sortColumn = column;
        _ascending = true;
      }

      _patients.sort((a, b) {
        final int comparison = switch (column) {
          _SortColumn.patient => b.name.compareTo(a.name),
          _SortColumn.status => b.statusPriority.compareTo(a.statusPriority),
          _SortColumn.spo2 => b.spo2.compareTo(a.spo2),
          _SortColumn.pulse => b.pulse.compareTo(a.pulse),
          _SortColumn.temp => b.temp.compareTo(a.temp),
          _SortColumn.lastSync => b.lastSyncMinutes.compareTo(
            a.lastSyncMinutes,
          ),
        };
        return _ascending ? comparison : -comparison;
      });
    });
  }

  /// Wraps each cell so it takes at least [minWidth] on narrow screens,
  /// and expands proportionally with [flex] when extra width is available.
  Widget _buildCell({
    required double minWidth,
    required int flex,
    required Widget child,
  }) {
    return Expanded(
      flex: flex,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: minWidth),
        child: child,
      ),
    );
  }

  Widget _buildHeaderCell(
    String label,
    _SortColumn column, {
    required double minWidth,
    int flex = 1,
    bool alignRight = false,
  }) {
    final bool isActive = _sortColumn == column;

    return _buildCell(
      minWidth: minWidth,
      flex: flex,
      child: InkWell(
        onTap: () => _onSort(column),
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment: alignRight
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive ? Colors.black : Colors.black87,
                ),
              ),
              if (isActive) ...[
                const SizedBox(width: 4.0),
                Icon(
                  _ascending ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 14.0,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Minimum widths per column so content never wraps awkwardly on small screens
    const double patientMinW = 175.0;
    const double statusMinW = 105.0;
    const double spo2MinW = 68.0;
    const double pulseMinW = 82.0;
    const double tempMinW = 68.0;
    const double lastSyncMinW = 110.0;

    return Container(
      padding: EdgeInsets.all(isSmall ? 8.0 : 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fixed Top Header (does not scroll horizontally)
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(isSmall ? 8.0 : 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.priorityPatients,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    child: Text(AppLocalizations.of(context)!.viewAll),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const NotImplementedDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Horizontally Scrollable Table (Column Headers + Rows)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: IntrinsicWidth(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Column Headers
                          Material(
                            color: const Color(0xFFF1F1F1),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 8.0,
                              ),
                              child: Row(
                                children: [
                                  _buildHeaderCell(
                                    '${AppLocalizations.of(context)!.patient} & ${AppLocalizations.of(context)!.room}'.toUpperCase(),
                                    _SortColumn.patient,
                                    minWidth: patientMinW,
                                    flex: 3,
                                  ),
                                  _buildHeaderCell(
                                    AppLocalizations.of(context)!.status.toUpperCase(),
                                    _SortColumn.status,
                                    minWidth: statusMinW,
                                    flex: 2,
                                  ),
                                  _buildHeaderCell(
                                    AppLocalizations.of(context)!.spo2.toUpperCase(),
                                    _SortColumn.spo2,
                                    minWidth: spo2MinW,
                                  ),
                                  _buildHeaderCell(
                                    AppLocalizations.of(context)!.pulse.toUpperCase(),
                                    _SortColumn.pulse,
                                    minWidth: pulseMinW,
                                  ),
                                  _buildHeaderCell(
                                    AppLocalizations.of(context)!.temp.toUpperCase(),
                                    _SortColumn.temp,
                                    minWidth: tempMinW,
                                  ),
                                  _buildHeaderCell(
                                    AppLocalizations.of(context)!.lastSync.toUpperCase(),
                                    _SortColumn.lastSync,
                                    minWidth: lastSyncMinW,
                                    flex: 2,
                                    alignRight: true,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Patient Rows
                          Material(
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (int i = 0; i < _patients.length; i++) ...[
                                  if (i > 0)
                                    const Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Color(0xFFF1F1F1),
                                    ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const NotImplementedDialog(),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 12.0,
                                      ),
                                      child: Row(
                                        children: [
                                          _buildCell(
                                            minWidth: patientMinW,
                                            flex: 3,
                                            child: Text(
                                              '${_patients[i].name} - ${_patients[i].room}',
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ),
                                          _buildCell(
                                            minWidth: statusMinW,
                                            flex: 2,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Pill(
                                                text: _patients[i].status,
                                                color: _patients[i].statusColor,
                                              ),
                                            ),
                                          ),
                                          _buildCell(
                                            minWidth: spo2MinW,
                                            flex: 1,
                                            child: Text(
                                              '${_patients[i].spo2}%',
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ),
                                          _buildCell(
                                            minWidth: pulseMinW,
                                            flex: 1,
                                            child: Text(
                                              '${_patients[i].pulse} BPM',
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ),
                                          _buildCell(
                                            minWidth: tempMinW,
                                            flex: 1,
                                            child: Text(
                                              '${_patients[i].temp}°C',
                                              maxLines: 1,
                                              softWrap: false,
                                            ),
                                          ),
                                          _buildCell(
                                            minWidth: lastSyncMinW,
                                            flex: 2,
                                            child: Text(
                                              _patients[i].lastSyncLabel,
                                              maxLines: 1,
                                              softWrap: false,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
      ),
    );
  }
}
