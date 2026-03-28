import 'package:flutter/material.dart';

class Timeline extends StatelessWidget {
  final List<TimelineItem> children;
  final String? title;
  final Color accentColor;

  const Timeline({super.key, required this.children, required this.accentColor, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

        for (int i = 0; i < children.length; i++) ...[
          if (i > 0) Container(width: 2, height: 20, margin: EdgeInsets.symmetric(horizontal: 6), color: Colors.grey),
          TimelineItem(color: accentColor, child: children[i].child),
        ],
      ],
    );
  }
}

class TimelineItem extends StatelessWidget {
  final Widget child;
  final Color color;

  const TimelineItem({super.key, required this.child, this.color = Colors.indigo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Expanded(child: child),
      ],
    );
  }
}
