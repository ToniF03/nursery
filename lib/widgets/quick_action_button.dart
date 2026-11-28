import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';

class QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(layoutPadding),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: widget.onPressed,
          hoverColor: Theme.of(context).primaryColor,
          onHover: (hovering) {
            setState(() => isHovered = hovering);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 140,
            height: 104,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: 28,
                  color: isHovered
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.label.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: isHovered ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
