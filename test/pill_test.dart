import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nursery/widgets/pill.dart';

void main() {
  testWidgets('background wraps the label inside a wide parent', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(width: 300, child: Pill(text: 'Stable')),
        ),
      ),
    );

    final background = find.descendant(
      of: find.byType(Pill),
      matching: find.byWidgetPredicate(
        (widget) => widget is Container && widget.decoration is BoxDecoration,
      ),
    );

    expect(tester.getSize(background).width, lessThan(300));
  });
}
