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
    final content = ConstrainedBox(
      constraints: BoxConstraints(minWidth: 120, minHeight: 51),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon, size: 30),
            SizedBox(width: 6),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

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
