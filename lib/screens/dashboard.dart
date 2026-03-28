import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nursery/app_layout_state.dart';
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
    return Padding(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
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
                      fillColor: const Color(0xFFF1F3F5),
                      hintText: 'Search for patients, schedules, or messages',
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
                  icon: Icon(Icons.notifications, size: 25, color: Colors.grey),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const NotImplementedDialog(),
                    );
                  },
                ),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 25,
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
              padding: EdgeInsets.all(12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final mobileLayout = !isDesktop;
                  final minCardsWidth = 280.0;
                  final greetingWidth = (constraints.maxWidth - minCardsWidth)
                      .clamp(220.0, constraints.maxWidth)
                      .toDouble();

                  final staffRatioCard = DashboardInfoCard(
                    icon: Icons.people,
                    label: 'STAFF RATIO',
                    value: '1:3',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const NotImplementedDialog(),
                      );
                    },
                  );

                  final currentTimeCard = DashboardInfoCard(
                    icon: Icons.schedule,
                    label: 'Current Time',
                    value: _currentTime(),
                  );

                  return Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SizedBox(
                        width: greetingWidth,
                        child: const Text(
                          'Good morning, Toni',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (mobileLayout)
                        SizedBox(
                          width: constraints.maxWidth,
                          child: Row(
                            children: [
                              Expanded(child: staffRatioCard),
                              const SizedBox(width: 12),
                              Expanded(child: currentTimeCard),
                            ],
                          ),
                        )
                      else
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            staffRatioCard,
                            const SizedBox(width: 12),
                            currentTimeCard,
                          ],
                        ),
                    ],
                  );
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: FractionallySizedBox(
                  widthFactor: isDesktop ? 2 / 5 : 1,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Urgent Alerts',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Pill(text: '4 HIGH', color: Colors.red, bold: true),
                        ],
                      ),
                      SizedBox(height: 12),
                      AlertCard(
                        title: 'Room 101 - J. Doe',
                        subtitle: 'Tachycardia detected',
                        description:
                            'Spiked from 88 BPM at 18:42. Patient reported mild chest tightness.',
                        color: Colors.red,
                        data: "155",
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const NotImplementedDialog(),
                          );
                        },
                      ),
                      AlertCard(
                        title: 'Room 102 - A. Johnson',
                        subtitle: 'Pain Meds Due',
                        description:
                            'Post-op Morphine (5mg) scheduled 10 mins ago. Pain scale currently 7/10.',
                        color: Colors.brown,
                        data: Icon(Icons.alarm_rounded, size: 40),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => const NotImplementedDialog(),
                          );
                        },
                      ),

                      Timeline(
                        title: 'Today\'s Shift Timeline',
                        accentColor: Colors.indigo,
                        children: [
                          TimelineItem(
                            child: Text(
                              '18:45 - Room 101 - J. Doe - Tachycardia resolved',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          TimelineItem(
                            child: Text(
                              '18:30 - Room 103 - M. Smith - Fall detected',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          TimelineItem(
                            child: Text(
                              '18:15 - Room 102 - A. Johnson - Pain meds administered',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      
    );
  }
}
