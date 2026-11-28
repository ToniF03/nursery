import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/globals.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/dashboard/dashboard_info_bar.dart';

void main() {
  testWidgets('updates the greeting immediately when the username changes', (
    tester,
  ) async {
    Globals().userName = null;
    addTearDown(() => Globals().userName = null);

    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: DashboardInfoBar()),
      ),
    );

    Globals().userName = 'Toni';
    await tester.pump();

    expect(find.textContaining('Toni'), findsOneWidget);
  });
}
