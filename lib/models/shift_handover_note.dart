import 'package:material_ui/material_ui.dart';

class ShiftHandoverNote {
  const ShiftHandoverNote({
    required this.patientName,
    required this.room,
    required this.note,
    required this.color,
  });

  final String patientName;
  final String room;
  final String note;
  final Color color;
}
