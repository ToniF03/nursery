import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/pill.dart';
import 'package:nursery/widgets/table_view.dart';

class PriorityPatientRow {
  const PriorityPatientRow({
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

const List<PriorityPatientRow> demoPriorityPatients = [
  PriorityPatientRow(
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
  PriorityPatientRow(
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
  PriorityPatientRow(
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

class DashboardPriorityPatientsTable extends StatelessWidget {
  const DashboardPriorityPatientsTable({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.all(isSmall ? 8 : 12),
      child: TableView<PriorityPatientRow>(
        title: localizations.priorityPatients,
        onViewAll: () {
          showDialog<void>(
            context: context,
            builder: (context) => const NotImplementedDialog(),
          );
        },
        onRowTap: (_) {
          showDialog<void>(
            context: context,
            builder: (context) => const NotImplementedDialog(),
          );
        },
        columns: [
          TableViewColumn(
            label: '${localizations.patient} & ${localizations.room}',
            cellBuilder: (context, patient) => Text(
              '${patient.name} - ${patient.room}',
              maxLines: 1,
              softWrap: false,
            ),
            compare: (first, second) => first.name.compareTo(second.name),
            minWidth: 175,
            flex: 3,
          ),
          TableViewColumn(
            label: localizations.status,
            cellBuilder: (context, patient) =>
                Pill(text: patient.status, color: patient.statusColor),
            compare: (first, second) =>
                first.statusPriority.compareTo(second.statusPriority),
            minWidth: 105,
            flex: 2,
          ),
          TableViewColumn(
            label: localizations.spo2,
            cellBuilder: (context, patient) =>
                Text('${patient.spo2}%', maxLines: 1, softWrap: false),
            compare: (first, second) => first.spo2.compareTo(second.spo2),
            minWidth: 68,
          ),
          TableViewColumn(
            label: localizations.pulse,
            cellBuilder: (context, patient) =>
                Text('${patient.pulse} BPM', maxLines: 1, softWrap: false),
            compare: (first, second) => first.pulse.compareTo(second.pulse),
            minWidth: 82,
          ),
          TableViewColumn(
            label: localizations.temp,
            cellBuilder: (context, patient) =>
                Text('${patient.temp}°C', maxLines: 1, softWrap: false),
            compare: (first, second) => first.temp.compareTo(second.temp),
            minWidth: 68,
          ),
          TableViewColumn(
            label: localizations.lastSync,
            cellBuilder: (context, patient) => Text(
              patient.lastSyncLabel,
              maxLines: 1,
              softWrap: false,
              textAlign: TextAlign.end,
            ),
            compare: (first, second) =>
                first.lastSyncMinutes.compareTo(second.lastSyncMinutes),
            minWidth: 110,
            flex: 2,
            alignRight: true,
          ),
        ],
        rows: demoPriorityPatients,
      ),
    );
  }
}
