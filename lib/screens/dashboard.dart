import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nursery/app_layout_state.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/alert_card.dart';
import 'package:nursery/widgets/dashboard_info_card.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/pill.dart';
import 'package:nursery/widgets/timeline.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _alignTimer;
  Timer? _clockTimer;

  @override
  void initState() {
    super.initState();
    _startAlignedClock();
  }

  void _startAlignedClock() {
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

  String _currentTime() {
    final DateTime now = DateTime.now();
    final String hours = now.hour.toString().padLeft(2, '0');
    final String minutes = now.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  void dispose() {
    _alignTimer?.cancel();
    _clockTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmall = screenWidth < 600;

    return Padding(
      padding: EdgeInsets.fromLTRB(isSmall ? 12 : 24, isSmall ? 8 : 10, isSmall ? 12 : 24, isSmall ? 8 : 10),
      child: SingleChildScrollView(
        child: 
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: isSmall ? 12 : 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  enabled: true,
                  readOnly: false,
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.indigo,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF1F1F1),
                    hintText: AppLocalizations.of(context)!.searchHeadline,
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(Icons.notifications, size: isSmall ? 20 : 25, color: Colors.grey),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: Icon(
                  Icons.account_circle,
                  size: isSmall ? 20 : 25,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.all(isSmall ? 8 : 12),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final mobileLayout = constraints.maxWidth < 700 || isSmall;
                final double cardMinWidth = 220.0;

                Widget constrainedCard(Widget child) => ConstrainedBox(
                      constraints: BoxConstraints(minWidth: cardMinWidth, maxWidth: 360),
                      child: child,
                    );

                final staffRatioCard = constrainedCard(DashboardInfoCard(
                  icon: Icons.people,
                  label: AppLocalizations.of(context)!.staffRatio,
                  value: '1:3',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => const NotImplementedDialog(),
                    );
                  },
                ));

                final currentTimeCard = DashboardInfoCard(
                  icon: Icons.schedule,
                  label: AppLocalizations.of(context)!.currentTime,
                  value: _currentTime(),
                );

                // Greeting + info cards
                if (mobileLayout) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.goodMorning("Toni"),
                        style: TextStyle(
                          fontSize: isSmall ? 18 : 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(child: staffRatioCard),
                          SizedBox(width: 12),
                          Expanded(child: constrainedCard(currentTimeCard)),
                        ],
                      ),
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                        'Good morning, Toni',
                        style: TextStyle(
                          fontSize: isSmall ? 18 : 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    staffRatioCard,
                    SizedBox(width: 12),
                    constrainedCard(currentTimeCard),
                  ],
                );
              },
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.urgentAlerts,
                                      style: TextStyle(
                                        fontSize: isSmall ? 16 : 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Pill(
                                    text: '4 ${AppLocalizations.of(context)!.high.toUpperCase()}',
                                    color: Colors.red,
                                    bold: true,
                                  ),
                                ],
                              ),
                              SizedBox(height: isSmall ? 8 : 12),
                              AlertCard(
                                title: '${AppLocalizations.of(context)!.room("101")} - J. Doe',
                                subtitle: 'Tachycardia detected',
                                description:
                                    'Spiked from 88 BPM at 18:42. Patient reported mild chest tightness.',
                                color: Colors.red,
                                data: "155",
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const NotImplementedDialog(),
                                  );
                                },
                              ),
                              AlertCard(
                                title: '${AppLocalizations.of(context)!.room("102")} - A. Johnson',
                                subtitle: 'Pain Meds Due',
                                description:
                                    'Post-op Morphine (5mg) scheduled 10 mins ago. Pain scale currently 7/10.',
                                color: Colors.brown,
                                data: Icon(Icons.alarm_rounded, size: isSmall ? 32 : 40),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const NotImplementedDialog(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          flex: 3,
                          child: Timeline(
                            title: 'Today\'s Shift Timeline',
                            accentColor: Colors.indigo,
                            children: [
                              TimelineItem(
                                child: Text(
                                  '18:45 - ${AppLocalizations.of(context)!.room("101")} - J. Doe - Tachycardia resolved',
                                  style: TextStyle(fontSize: isSmall ? 13 : 14),
                                ),
                              ),
                              TimelineItem(
                                child: Text(
                                  '18:30 - ${AppLocalizations.of(context)!.room("103")} - M. Smith - Fall detected',
                                  style: TextStyle(fontSize: isSmall ? 13 : 14),
                                ),
                              ),
                              TimelineItem(
                                child: Text(
                                  '18:15 - ${AppLocalizations.of(context)!.room("102")} - A. Johnson - Pain meds administered',
                                  style: TextStyle(fontSize: isSmall ? 13 : 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      AppLocalizations.of(context)!.urgentAlerts,
                                      style: TextStyle(
                                        fontSize: isSmall ? 16 : 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Pill(
                                    text: '4 ${AppLocalizations.of(context)!.high.toUpperCase()}',
                                    color: Colors.red,
                                    bold: true,
                                  ),
                                ],
                              ),
                              SizedBox(height: isSmall ? 8 : 12),
                              AlertCard(
                                title: '${AppLocalizations.of(context)!.room("101")} - J. Doe',
                                subtitle: 'Tachycardia detected',
                                description:
                                    'Spiked from 88 BPM at 18:42. Patient reported mild chest tightness.',
                                color: Colors.red,
                                data: "155",
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const NotImplementedDialog(),
                                  );
                                },
                              ),
                              AlertCard(
                                title: '${AppLocalizations.of(context)!.room("102")} - A. Johnson',
                                subtitle: 'Pain Meds Due',
                                description:
                                    'Post-op Morphine (5mg) scheduled 10 mins ago. Pain scale currently 7/10.',
                                color: Colors.brown,
                                data: Icon(Icons.alarm_rounded, size: isSmall ? 32 : 40),
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        const NotImplementedDialog(),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: isSmall ? 8 : 12),
                        FractionallySizedBox(
                          widthFactor: 1,
                          child: Timeline(
                            title: 'Today\'s Shift Timeline',
                            accentColor: Colors.indigo,
                            children: [
                              TimelineItem(
                                child: Text(
                                  '18:45 - ${AppLocalizations.of(context)!.room("101")} - J. Doe - Tachycardia resolved',
                                  style: TextStyle(fontSize: isSmall ? 13 : 14),
                                ),
                              ),
                              TimelineItem(
                                child: Text(
                                  '18:30 - ${AppLocalizations.of(context)!.room("103")} - M. Smith - Fall detected',
                                  style: TextStyle(fontSize: isSmall ? 13 : 14),
                                ),
                              ),
                              TimelineItem(
                                child: Text(
                                  '18:15 - ${AppLocalizations.of(context)!.room("102")} - A. Johnson - Pain meds administered',
                                  style: TextStyle(fontSize: isSmall ? 13 : 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    
      ));
  }
}

