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

    final content = ConstrainedBox(
      constraints: BoxConstraints(minWidth: 51, minHeight: 51),
      child: ClipRRect(
        borderRadius: borderRadius,
        clipBehavior: Clip.hardEdge,
        child: Ink(
          width: double.infinity,
          height: 150,
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
                margin: EdgeInsets.fromLTRB(20, 7.5, 7.5, 7.5),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: rightPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            subtitle,
                            style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              description,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (dataWidget != null)
                      Positioned(top: 5, right: 10, child: dataWidget),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

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
