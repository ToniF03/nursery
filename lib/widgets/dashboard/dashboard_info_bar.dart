import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/core/globals.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/dashboard/dashboard_info_card.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';

class DashboardInfoBar extends StatefulWidget {
  const DashboardInfoBar({super.key});

  @override
  State<DashboardInfoBar> createState() => _DashboardInfoBarState();
}

class _DashboardInfoBarState extends State<DashboardInfoBar> {
  Timer? _alignTimer;
  Timer? _clockTimer;

  @override
  void initState() {
    super.initState();
    Globals().userNameListenable.addListener(_onUserNameChanged);
    // Start the clock aligned to a minute boundary, then update every second.
    _startAlignedClock();
  }

  void _onUserNameChanged() {
    if (mounted) setState(() {});
  }

  String _currentTime() {
    final DateTime now = DateTime.now();
    final String hours = now.hour.toString().padLeft(2, '0');
    final String minutes = now.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  int get currentHour => DateTime.now().hour;

  String get greeting {
    if (currentHour < 12) {
      return AppLocalizations.of(
        context,
      )!.goodMorning(Globals().userName ?? "");
    } else if (currentHour < 18) {
      return AppLocalizations.of(
        context,
      )!.goodAfternoon(Globals().userName ?? "");
    } else {
      return AppLocalizations.of(
        context,
      )!.goodEvening(Globals().userName ?? "");
    }
  }

  void _startAlignedClock() {
    // Wait until the next minute before starting the periodic clock timer.
    final DateTime now = DateTime.now();
    final Duration delay = Duration(
      seconds: 60 - now.second,
      milliseconds: -now.millisecond,
      microseconds: -now.microsecond,
    );

    _alignTimer = Timer(delay, () {
      if (!mounted) return;

      setState(() {});
      _clockTimer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) {
          setState(() {});
        }
      });
    });
  }

  @override
  void dispose() {
    Globals().userNameListenable.removeListener(_onUserNameChanged);
    _alignTimer?.cancel();
    _clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final greeting = this.greeting;

        final greetingStyle = TextStyle(
          fontSize: isSmall ? 18 : 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        );

        final textPainter = TextPainter(
          text: TextSpan(text: greeting, style: greetingStyle),
          textDirection: Directionality.of(context),
        )..layout();

        const spacing = 8.0;
        const minCardWidth = 150.0;

        final greetingWidget = Text(greeting, style: greetingStyle);

        final staffCard = DashboardInfoCard(
          icon: Icons.people,
          label: AppLocalizations.of(context)!.staffRatio,
          value: '1:3',
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const NotImplementedDialog(),
            );
          },
        );

        final timeCard = DashboardInfoCard(
          icon: Icons.schedule,
          label: AppLocalizations.of(context)!.currentTime,
          value: _currentTime(),
        );

        const cardsMinWidth = minCardWidth * 2 + spacing;

        if (constraints.maxWidth >=
            textPainter.width + cardsMinWidth + spacing) {
          return Row(
            children: [
              greetingWidget,
              const SizedBox(width: spacing),
              Expanded(child: staffCard),
              const SizedBox(width: spacing),
              Expanded(child: timeCard),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            greetingWidget,
            const SizedBox(height: spacing),

            LayoutBuilder(
              builder: (context, cardConstraints) {
                // Beide Cards passen noch nebeneinander
                if (cardConstraints.maxWidth >= cardsMinWidth) {
                  return Row(
                    children: [
                      Expanded(child: staffCard),
                      const SizedBox(width: spacing),
                      Expanded(child: timeCard),
                    ],
                  );
                }

                return Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [staffCard, timeCard],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
