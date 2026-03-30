import 'package:flutter/material.dart';

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
        color: Colors.white,
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
            TimelineItem(
              color: accentColor,
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
  final Widget child;
  final Color color;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.child,
    this.color = Colors.indigo,
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
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLast) ...[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: const VerticalDivider(
                        thickness: 2,
                        width: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            fit: FlexFit.loose,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
