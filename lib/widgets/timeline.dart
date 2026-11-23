import 'package:material_ui/material_ui.dart';

// Displays a titled list of events with a shared accent color.
class Timeline extends StatelessWidget {
  final List<TimelineItem> children;
  final String? title;
  final Color accentColor;

  const Timeline({
    super.key,
    required this.children,
    required this.accentColor,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

          for (int i = 0; i < children.length; i++) ...[
            // Hide endpoint divider segments and apply the item's position styling.
            TimelineItem(
              color: accentColor,
              isFirst: i == 0,
              isLast: i == children.length - 1,
              child: children[i].child,
            ),
          ],
        ],
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  // A timeline item with optional first/last endpoint behavior.
  final Widget child;
  final Color color;
  final bool isFirst;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.child,
    this.color = Colors.indigo,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: isFirst
                        ? const SizedBox.shrink()
                        : const VerticalDivider(
                            thickness: 2,
                            width: 2,
                            color: Colors.grey,
                          ),
                  ),
                ),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: isLast
                        ? const SizedBox.shrink()
                        : const VerticalDivider(
                            thickness: 2,
                            width: 2,
                            color: Colors.grey,
                          ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: Padding(padding: const EdgeInsets.all(12), child: child),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
