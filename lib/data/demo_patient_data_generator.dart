import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:nursery/models/priority_patient_row.dart';
import 'package:nursery/models/shift_handover_note.dart';

class DemoPatientDataGenerator {
  DemoPatientDataGenerator({int? seed}) : _random = Random(seed);

  final Random _random;

  static const _firstNames = [
    'Abigail',
    'Adam',
    'Alex',
    'Amelia',
    'Andrew',
    'Ava',
    'Benjamin',
    'Chloe',
    'Daniel',
    'Eleanor',
    'Elijah',
    'Emily',
    'Ethan',
    'Grace',
    'Harper',
    'Henry',
    'Isabella',
    'Jack',
    'James',
    'Lily',
    'Liam',
    'Lucas',
    'Mia',
    'Michael',
    'Noah',
    'Oliver',
    'Olivia',
    'Owen',
    'Sophia',
    'Theodore',
    'Tina',
    'William',
  ];

  static const _lastNames = [
    'Adams',
    'Anderson',
    'Baker',
    'Bennett',
    'Brooks',
    'Carter',
    'Collins',
    'Cooper',
    'Davis',
    'Edwards',
    'Evans',
    'Foster',
    'Gray',
    'Harris',
    'Hayes',
    'Hill',
    'Jackson',
    'Johnson',
    'Kelly',
    'Lewis',
    'Martin',
    'Mitchell',
    'Morgan',
    'Parker',
    'Reed',
    'Roberts',
    'Scott',
    'Smith',
    'Taylor',
    'Turner',
    'Walker',
    'White',
    'Wilson',
  ];

  static const _handoverProfiles = [
    _HandoverProfile(
      note:
          'Oxygen saturation was below the usual range during the last check. '
          'Please repeat observations and escalate any further decline.',
      color: Colors.red,
    ),
    _HandoverProfile(
      note:
          'Heart rate remains elevated after rest. Please recheck during the '
          'next round and update the nurse in charge if it continues.',
      color: Colors.orange,
    ),
    _HandoverProfile(
      note:
          'Patient reported increased pain after medication. Reassess the pain '
          'score at the next check.',
      color: Colors.orange,
    ),
    _HandoverProfile(
      note:
          "Blood pressure was lower than the patient's usual baseline. Please "
          'repeat the measurement at the next observation.',
      color: Colors.orange,
    ),
    _HandoverProfile(
      note:
          'Patient is at increased risk of falling. Keep the call bell within '
          'reach and offer assistance when moving.',
      color: Colors.orange,
    ),
    _HandoverProfile(
      note:
          'Please check that the dressing remains clean and dry during the '
          'next round.',
      color: Colors.blue,
    ),
    _HandoverProfile(
      note:
          'Appetite was reduced at lunch. Offer fluids and record intake at '
          'the next meal.',
      color: Colors.blue,
    ),
    _HandoverProfile(
      note:
          'Patient is resting comfortably after the morning round. Continue '
          'routine observations.',
      color: Colors.green,
    ),
    _HandoverProfile(
      note:
          "Family requested an update after the physician's round. Please "
          'follow up when the plan is available.',
      color: Colors.blue,
    ),
  ];

  List<PriorityPatientRow> generatePriorityPatients(int count) {
    _validateCount(count);

    return List<PriorityPatientRow>.generate(count, (index) {
      final status = switch (_random.nextInt(10)) {
        < 2 => _PatientStatus.critical,
        < 5 => _PatientStatus.warning,
        _ => _PatientStatus.stable,
      };
      final profile = switch (status) {
        _PatientStatus.critical => const _PatientStatusProfile(
          label: 'Critical',
          priority: 3,
          color: Colors.red,
          minSpo2: 85,
          maxSpo2: 92,
          minPulse: 110,
          maxPulse: 145,
          minTemperatureTenths: 380,
          maxTemperatureTenths: 405,
        ),
        _PatientStatus.warning => const _PatientStatusProfile(
          label: 'Warning',
          priority: 2,
          color: Colors.orange,
          minSpo2: 93,
          maxSpo2: 95,
          minPulse: 90,
          maxPulse: 110,
          minTemperatureTenths: 375,
          maxTemperatureTenths: 390,
        ),
        _PatientStatus.stable => const _PatientStatusProfile(
          label: 'Stable',
          priority: 1,
          color: Colors.green,
          minSpo2: 96,
          maxSpo2: 100,
          minPulse: 60,
          maxPulse: 100,
          minTemperatureTenths: 360,
          maxTemperatureTenths: 374,
        ),
      };
      final lastSyncMinutes = _random.nextInt(60);

      return PriorityPatientRow(
        name: _generatePatientName(),
        room: 'Room ${101 + index}',
        status: profile.label,
        statusPriority: profile.priority,
        statusColor: profile.color,
        spo2: _between(profile.minSpo2, profile.maxSpo2),
        pulse: _between(profile.minPulse, profile.maxPulse),
        temp:
            _between(
              profile.minTemperatureTenths,
              profile.maxTemperatureTenths,
            ) /
            10,
        lastSyncMinutes: lastSyncMinutes,
        lastSyncLabel: _formatLastSync(lastSyncMinutes),
      );
    }, growable: false);
  }

  List<ShiftHandoverNote> generateShiftHandoverNotes(int count) {
    _validateCount(count);

    return List<ShiftHandoverNote>.generate(count, (index) {
      final profile =
          _handoverProfiles[_random.nextInt(_handoverProfiles.length)];
      return ShiftHandoverNote(
        patientName: _generatePatientName(),
        room: 'Room ${101 + index}',
        note: profile.note,
        color: profile.color,
      );
    }, growable: false);
  }

  void _validateCount(int count) {
    if (count < 0) {
      throw ArgumentError.value(
        count,
        'count',
        'Must be greater than or equal to zero.',
      );
    }
  }

  String _generatePatientName() {
    return '${_firstNames[_random.nextInt(_firstNames.length)]} '
        '${_lastNames[_random.nextInt(_lastNames.length)]}';
  }

  int _between(int minimum, int maximum) {
    return minimum + _random.nextInt(maximum - minimum + 1);
  }

  String _formatLastSync(int minutes) {
    if (minutes == 0) return 'Just now';
    if (minutes == 1) return '1 min ago';
    return '$minutes mins ago';
  }
}

class _HandoverProfile {
  const _HandoverProfile({required this.note, required this.color});

  final String note;
  final Color color;
}

enum _PatientStatus { critical, warning, stable }

class _PatientStatusProfile {
  const _PatientStatusProfile({
    required this.label,
    required this.priority,
    required this.color,
    required this.minSpo2,
    required this.maxSpo2,
    required this.minPulse,
    required this.maxPulse,
    required this.minTemperatureTenths,
    required this.maxTemperatureTenths,
  });

  final String label;
  final int priority;
  final Color color;
  final int minSpo2;
  final int maxSpo2;
  final int minPulse;
  final int maxPulse;
  final int minTemperatureTenths;
  final int maxTemperatureTenths;
}
