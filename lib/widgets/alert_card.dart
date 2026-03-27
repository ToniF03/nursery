import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final VoidCallback? onTap;

  const AlertCard({
    super.key,
    required this.title,
    required this.description,
    this.color = Colors.red,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = ConstrainedBox(
      constraints: BoxConstraints(minWidth: 120, minHeight: 51),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        clipBehavior: Clip.hardEdge,
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(color: color),
          child: Padding(
            padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return Card(
      clipBehavior: Clip.hardEdge,
      child: onTap != null
          ? InkWell(
              splashColor: Colors.red.withAlpha(30),
              onTap: onTap,
              child: content,
            )
          : content,
    );
  }
}
