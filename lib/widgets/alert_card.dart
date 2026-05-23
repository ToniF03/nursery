import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final Color color;
  // Accepts either a String or an Icon.
  final Object? data;
  final VoidCallback? onTap;

  const AlertCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    this.color = Colors.red,
    this.data,
    this.onTap,
  }) : assert(
         data == null || data is String || data is Icon,
         'data must be either a String or an Icon',
       );

  Widget? _buildData() {
    if (data == null) return null;

    return switch (data) {
      String value => Text(
        value,
        style: TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.bold),
      ),
      Icon icon => Icon(icon.icon, size: icon.size, color: color),
      _ => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final dataWidget = _buildData();
    final rightPadding = dataWidget != null ? 84.0 : 0.0;
    final borderRadius = BorderRadius.circular(12);

    final content = LayoutBuilder(builder: (context, constraints) {
      final w = constraints.maxWidth;
      final titleSize = w.isFinite && w < 360 ? 16.0 : 18.0;
      final subtitleSize = w.isFinite && w < 360 ? 12.0 : 14.0;
      final descSize = w.isFinite && w < 360 ? 12.0 : 14.0;

      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 51, minHeight: 110),
        child: ClipRRect(
          borderRadius: borderRadius,
          clipBehavior: Clip.hardEdge,
          child: Ink(
            width: double.infinity,
            decoration: BoxDecoration(color: color),
            child: Padding(
              padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
              child: Ink(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.fromLTRB(16, 10, 10, 10),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: rightPadding),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: titleSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              subtitle,
                              style: TextStyle(fontSize: subtitleSize, color: color, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              description,
                              style: TextStyle(fontSize: descSize),
                            ),
                          ],
                        ),
                      ),
                      if (dataWidget != null)
                        Positioned(top: 8, right: 10, child: dataWidget),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });

    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: onTap,
        customBorder: RoundedRectangleBorder(borderRadius: borderRadius),
        splashColor: color.withAlpha(24),
        highlightColor: color.withAlpha(10),
        child: content,
      ),
    );
  }
}
