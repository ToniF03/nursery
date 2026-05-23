import 'package:flutter/material.dart';

class DashboardInfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const DashboardInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final iconSize = w.isFinite && w < 200 ? 22.0 : 30.0;
      final labelSize = w.isFinite && w < 200 ? 9.0 : 10.0;
      final valueSize = w.isFinite && w < 200 ? 14.0 : 15.0;
      final pad = w.isFinite && w < 200 ? 6.0 : 8.0;

      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 120, minHeight: 44),
        child: Padding(
          padding: EdgeInsets.all(pad),
          child: Row(
            children: [
              Icon(icon, size: iconSize),
              SizedBox(width: 8),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: labelSize,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: valueSize,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });

    return Card(
      clipBehavior: Clip.hardEdge,
      child: onTap != null
          ? InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: onTap,
              child: content,
            )
          : content,
    );
  }
}
