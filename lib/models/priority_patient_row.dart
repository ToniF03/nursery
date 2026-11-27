import 'package:material_ui/material_ui.dart';

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
