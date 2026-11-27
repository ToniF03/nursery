import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/main/main_drawer.dart';
import 'package:nursery/widgets/pill.dart';

void main() {
  testWidgets(
    'shows messaging pill while expanded and hides it when collapsed',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: MainDrawer(onSelectedMobileIndex: (_) {})),
        ),
      );

      expect(find.byType(Pill), findsOneWidget);
      expect(find.text('0'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pumpAndSettle();

      expect(find.byType(Pill), findsNothing);
    },
  );
}
