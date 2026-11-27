import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:nursery/models/priority_patient_row.dart';

class DemoPatientDataGenerator {
  DemoPatientDataGenerator({int? seed}) : _random = Random(seed);

  final Random _random;

  static const _firstNames = [
    'Alex',
    'Anna',
    'Ben',
    'Clara',
    'David',
    'Elena',
    'Emma',
    'Felix',
    'Hannah',
    'Jonas',
    'Laura',
    'Lea',
    'Liam',
    'Luca',
    'Marie',
    'Mia',
    'Noah',
    'Paul',
    'Sofia',
    'Theo',
  ];

  static const _lastNames = [
    'Bauer',
    'Becker',
    'Fischer',
    'Hoffmann',
    'Keller',
    'Klein',
    'Koch',
    'Krause',
    'Meyer',
    'Neumann',
    'Richter',
    'Schmidt',
    'Schneider',
    'Schulz',
    'Schwarz',
    'Weber',
  ];

  List<PriorityPatientRow> generatePriorityPatients(int count) {
    if (count < 0) {
      throw ArgumentError.value(
        count,
        'count',
        'Must be greater than or equal to zero.',
      );
    }

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
        name:
            '${_firstNames[_random.nextInt(_firstNames.length)]} '
            '${_lastNames[_random.nextInt(_lastNames.length)]}',
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

  int _between(int minimum, int maximum) {
    return minimum + _random.nextInt(maximum - minimum + 1);
  }

  String _formatLastSync(int minutes) {
    if (minutes == 0) return 'Just now';
    if (minutes == 1) return '1 min ago';
    return '$minutes mins ago';
  }
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
