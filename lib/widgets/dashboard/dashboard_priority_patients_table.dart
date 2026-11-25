import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
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
          _SortColumn.patient => a.name.compareTo(b.name),
          _SortColumn.status => a.statusPriority.compareTo(b.statusPriority),
          _SortColumn.spo2 => a.spo2.compareTo(b.spo2),
          _SortColumn.pulse => a.pulse.compareTo(b.pulse),
          _SortColumn.temp => a.temp.compareTo(b.temp),
          _SortColumn.lastSync => a.lastSyncMinutes.compareTo(b.lastSyncMinutes),
        };
        return _ascending ? comparison : -comparison;
      });
    });
  }

  Widget _buildHeaderCell(
    String label,
    _SortColumn column, {
    int flex = 1,
    bool alignRight = false,
  }) {
    final bool isActive = _sortColumn == column;

    return Expanded(
      flex: flex,
      child: InkWell(
        onTap: () => _onSort(column),
        borderRadius: BorderRadius.circular(4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          child: Row(
            mainAxisAlignment:
                alignRight ? MainAxisAlignment.end : MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                    color: isActive ? Colors.black : Colors.black87,
                  ),
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
    return Container(
      padding: EdgeInsets.all(isSmall ? 8.0 : 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    'Priority Patients',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    child: const Text('View All'),
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
          Material(
            color: const Color(0xFFF1F1F1),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  _buildHeaderCell('PATIENT & ROOM', _SortColumn.patient, flex: 3),
                  _buildHeaderCell('STATUS', _SortColumn.status, flex: 2),
                  _buildHeaderCell('SPO2', _SortColumn.spo2),
                  _buildHeaderCell('PULSE', _SortColumn.pulse),
                  _buildHeaderCell('TEMP', _SortColumn.temp),
                  _buildHeaderCell(
                    'LAST SYNC',
                    _SortColumn.lastSync,
                    flex: 2,
                    alignRight: true,
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
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
                        builder: (context) => const NotImplementedDialog(),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${_patients[i].name} - ${_patients[i].room}',
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Pill(
                                text: _patients[i].status,
                                color: _patients[i].statusColor,
                              ),
                            ),
                          ),
                          Expanded(child: Text('${_patients[i].spo2}%')),
                          Expanded(child: Text('${_patients[i].pulse} BPM')),
                          Expanded(child: Text('${_patients[i].temp}°C')),
                          Expanded(
                            flex: 2,
                            child: Text(
                              _patients[i].lastSyncLabel,
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
    );
  }
}