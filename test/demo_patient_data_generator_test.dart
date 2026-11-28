import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nursery/data/demo_patient_data_generator.dart';

void main() {
  test('generates the requested number of varied patients', () {
    final patients = DemoPatientDataGenerator(
      seed: 42,
    ).generatePriorityPatients(300);

    expect(patients, hasLength(300));
    expect(patients.map((patient) => patient.room).toSet(), hasLength(300));

    for (final patient in patients) {
      expect(patient.name, isNotEmpty);
      expect(patient.lastSyncMinutes, inInclusiveRange(0, 59));

      switch (patient.status) {
        case 'Critical':
          expect(patient.statusPriority, 3);
          expect(patient.statusColor, Colors.red);
          expect(patient.spo2, inInclusiveRange(85, 92));
          expect(patient.pulse, inInclusiveRange(110, 145));
          expect(patient.temp, inInclusiveRange(38.0, 40.5));
        case 'Warning':
          expect(patient.statusPriority, 2);
          expect(patient.statusColor, Colors.orange);
          expect(patient.spo2, inInclusiveRange(93, 95));
          expect(patient.pulse, inInclusiveRange(90, 110));
          expect(patient.temp, inInclusiveRange(37.5, 39.0));
        case 'Stable':
          expect(patient.statusPriority, 1);
          expect(patient.statusColor, Colors.green);
          expect(patient.spo2, inInclusiveRange(96, 100));
          expect(patient.pulse, inInclusiveRange(60, 100));
          expect(patient.temp, inInclusiveRange(36.0, 37.4));
        default:
          fail('Unexpected status: ${patient.status}');
      }
    }
  });

  test('seed produces repeatable demo data', () {
    final first = DemoPatientDataGenerator(
      seed: 123,
    ).generatePriorityPatients(20);
    final second = DemoPatientDataGenerator(
      seed: 123,
    ).generatePriorityPatients(20);

    expect(
      first.map((patient) => patient.name).toList(),
      second.map((patient) => patient.name).toList(),
    );
    expect(
      first.map((patient) => patient.status).toList(),
      second.map((patient) => patient.status).toList(),
    );
    expect(
      first.map((patient) => patient.spo2).toList(),
      second.map((patient) => patient.spo2).toList(),
    );
  });

  test('generates complete, repeatable English shift handover notes', () {
    final first = DemoPatientDataGenerator(
      seed: 456,
    ).generateShiftHandoverNotes(20);
    final second = DemoPatientDataGenerator(
      seed: 456,
    ).generateShiftHandoverNotes(20);

    expect(first, hasLength(20));
    expect(first.map((note) => note.room).toSet(), hasLength(20));
    expect(
      first.map((note) => '${note.patientName}|${note.room}|${note.note}'),
      second.map((note) => '${note.patientName}|${note.room}|${note.note}'),
    );

    for (final note in first) {
      expect(note.patientName, isNotEmpty);
      expect(note.room, startsWith('Room '));
      expect(note.note, isNotEmpty);
      expect([
        Colors.red,
        Colors.orange,
        Colors.blue,
        Colors.green,
      ], contains(note.color));
    }
  });

  test('rejects a negative patient count', () {
    expect(
      () => DemoPatientDataGenerator().generatePriorityPatients(-1),
      throwsArgumentError,
    );
    expect(
      () => DemoPatientDataGenerator().generateShiftHandoverNotes(-1),
      throwsArgumentError,
    );
  });
}
