import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/data/demo_patient_data_generator.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/models/priority_patient_row.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/pill.dart';
import 'package:nursery/widgets/table_view.dart';

class DashboardPriorityPatientsTable extends StatefulWidget {
  const DashboardPriorityPatientsTable({
    super.key,
    this.patients,
    this.demoPatientCount = 32,
  });

  final List<PriorityPatientRow>? patients;
  final int demoPatientCount;

  @override
  State<DashboardPriorityPatientsTable> createState() =>
      _DashboardPriorityPatientsTableState();
}

class _DashboardPriorityPatientsTableState
    extends State<DashboardPriorityPatientsTable> {
  late List<PriorityPatientRow> _demoPatients;

  @override
  void initState() {
    super.initState();
    if (widget.patients == null) {
      _generateDemoPatients();
    }
  }

  @override
  void didUpdateWidget(DashboardPriorityPatientsTable oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.patients == null &&
        (oldWidget.patients != null ||
            oldWidget.demoPatientCount != widget.demoPatientCount)) {
      _generateDemoPatients();
    }
  }

  void _generateDemoPatients() {
    _demoPatients =
        DemoPatientDataGenerator().generatePriorityPatients(
          widget.demoPatientCount,
        )..sort(
          (first, second) =>
              second.statusPriority.compareTo(first.statusPriority),
        );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final patients = widget.patients ?? _demoPatients;

    return Padding(
      padding: EdgeInsets.all(layoutPadding),
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
            cellBuilder: (context, patient) => Pill(
              text: _localizedStatus(localizations, patient.status),
              color: patient.statusColor,
            ),
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
        rows: patients,
      ),
    );
  }
}

String _localizedStatus(AppLocalizations localizations, String status) =>
    switch (status) {
      'Critical' => localizations.critical,
      'Warning' => localizations.warning,
      'Stable' => localizations.stable,
      'Unknown' => localizations.unknown,
      'Hospitalized' => localizations.hospitalized,
      _ => status,
    };
