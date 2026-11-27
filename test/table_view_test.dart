import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/models/priority_patient_row.dart';
import 'package:nursery/widgets/dashboard/dashboard_priority_patients_table.dart';
import 'package:nursery/widgets/table_view.dart';

void main() {
  const priorityPatients = [
    PriorityPatientRow(
      name: 'John Doe',
      room: 'Room 101',
      status: 'Critical',
      statusPriority: 3,
      statusColor: Colors.red,
      spo2: 90,
      pulse: 120,
      temp: 39,
      lastSyncMinutes: 10,
      lastSyncLabel: '10 mins ago',
    ),
    PriorityPatientRow(
      name: 'Anna Smith',
      room: 'Room 104',
      status: 'Warning',
      statusPriority: 2,
      statusColor: Colors.orange,
      spo2: 94,
      pulse: 98,
      temp: 38,
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

  testWidgets('sorts the externally supplied rows by every column', (
    tester,
  ) async {
    const rows = [(name: 'Zoe', age: 20), (name: 'Amy', age: 30)];
    String? tappedName;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: TableView<({String name, int age})>(
            title: 'Patients',
            showAllButton: false,
            columns: [
              TableViewColumn(
                label: 'Name',
                cellBuilder: (context, row) => Text(row.name),
                compare: (first, second) => first.name.compareTo(second.name),
              ),
              TableViewColumn(
                label: 'Age',
                cellBuilder: (context, row) => Text('${row.age}'),
                compare: (first, second) => first.age.compareTo(second.age),
              ),
            ],
            rows: rows,
            onRowTap: (row) => tappedName = row.name,
          ),
        ),
      ),
    );

    expect(_topOf(tester, 'Zoe'), lessThan(_topOf(tester, 'Amy')));

    await tester.tap(find.text('NAME'));
    await tester.pumpAndSettle();
    expect(_topOf(tester, 'Amy'), lessThan(_topOf(tester, 'Zoe')));
    await tester.tap(find.text('Amy'));
    expect(tappedName, 'Amy');

    await tester.tap(find.text('AGE'));
    await tester.pumpAndSettle();
    expect(_topOf(tester, 'Zoe'), lessThan(_topOf(tester, 'Amy')));

    await tester.tap(find.text('AGE'));
    await tester.pumpAndSettle();
    expect(_topOf(tester, 'Amy'), lessThan(_topOf(tester, 'Zoe')));
  });

  testWidgets('priority patients table displays and sorts its rows', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('de'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: DashboardPriorityPatientsTable(patients: priorityPatients),
        ),
      ),
    );

    expect(find.text('John Doe - Room 101'), findsOneWidget);
    expect(find.text('Kritisch'), findsOneWidget);
    expect(find.text('Warnung'), findsOneWidget);
    expect(find.text('Stabil'), findsOneWidget);
    expect(
      _topOf(tester, 'John Doe - Room 101'),
      lessThan(_topOf(tester, 'Max Weber - Room 102')),
    );

    await tester.tap(find.text('STATUS'));
    await tester.pumpAndSettle();
    expect(
      _topOf(tester, 'Max Weber - Room 102'),
      lessThan(_topOf(tester, 'John Doe - Room 101')),
    );
  });
}

double _topOf(WidgetTester tester, String text) {
  return tester.getTopLeft(find.text(text)).dy;
}
