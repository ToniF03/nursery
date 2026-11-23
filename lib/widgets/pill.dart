import 'package:material_ui/material_ui.dart';

// Small rounded label for compact status or category text.
class Pill extends StatelessWidget {
  final String text;
  final bool bold;
  final Color color;

  const Pill({
    super.key,
    required this.text,
    this.bold = false,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: bold ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    );
  }
}
