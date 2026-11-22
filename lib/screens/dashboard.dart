import 'package:flutter/material.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/alert_card.dart';
import 'package:nursery/widgets/dashboard/dashboard_info_bar.dart';
import 'package:nursery/widgets/dashboard/dashboard_top_bar.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/pill.dart';
import 'package:nursery/widgets/quick_action_button.dart';
import 'package:nursery/widgets/timeline.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // Controllers and timers owned by this screen.
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    // Outer layout keeps the dashboard scrollable on short or narrow screens.
    return Padding(
      padding: EdgeInsets.fromLTRB(
        isSmall ? 12 : 24,
        isSmall ? 8 : 10,
        isSmall ? 12 : 24,
        isSmall ? 8 : 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: isSmall ? 12 : 20),

            // Search and account actions.
            const DashboardTopBar(),

            Padding(
              padding: EdgeInsets.all(isSmall ? 8 : 12),
              child: const DashboardInfoBar(),
            ),

            Padding(
              padding: EdgeInsets.all(isSmall ? 8 : 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Quick Actions",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: isSmall ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: isSmall ? 8 : 12),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: isSmall ? 8 : 12,
                    children: [
                      QuickActionButton(
                        icon: Icons.medication,
                        label: "Log Meds",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const NotImplementedDialog(),
                          );
                        },
                      ),
                      QuickActionButton(
                        icon: Icons.monitor_heart_outlined,
                        label: "Record Vitals",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const NotImplementedDialog(),
                          );
                        },
                      ),
                      QuickActionButton(
                        icon: Icons.swap_horiz,
                        label: "Patient Transfer",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const NotImplementedDialog(),
                          );
                        },
                      ),
                      QuickActionButton(
                        icon: Icons.insert_drive_file_outlined,
                        label: "Report Incident",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const NotImplementedDialog(),
                          );
                        },
                      ),
                      QuickActionButton(
                        icon: Icons.message_outlined,
                        label: "Contact Physician",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const NotImplementedDialog(),
                          );
                        },
                      ),
                      QuickActionButton(
                        icon: Icons.add,
                        label: "Customize",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => const NotImplementedDialog(),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Urgent alerts and the shift timeline.
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isSmall ? 8 : 12),
              child: Align(
                alignment: Alignment.topLeft,
                child: _buildAlertsSection(
                  isDesktop: isDesktop,
                  isSmall: isSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsSection({required bool isDesktop, required bool isSmall}) {
    final localized = AppLocalizations.of(context)!;

    // Alert section header with the number of high-priority items.
    final headerRow = Row(
      children: [
        Expanded(
          child: Text(
            localized.urgentAlerts,
            style: TextStyle(
              fontSize: isSmall ? 16 : 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8),
        Pill(
          text: '4 ${localized.high.toUpperCase()}',
          color: Colors.red,
          bold: true,
        ),
      ],
    );

    // The left column contains the alert header and patient alert cards.
    final alertsColumn = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        headerRow,
        SizedBox(height: isSmall ? 8 : 12),
        AlertCard(
          title: '${localized.room("101")} - J. Doe',
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
          title: '${localized.room("102")} - A. Johnson',
          subtitle: 'Pain Meds Due',
          description:
              'Post-op Morphine (5mg) scheduled 10 mins ago. Pain scale currently 7/10.',
          color: Colors.brown,
          data: Icon(Icons.alarm_rounded, size: isSmall ? 32 : 40),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => const NotImplementedDialog(),
            );
          },
        ),
      ],
    );

    // Recent shift events are shown as a vertical timeline.
    final timelineWidget = Timeline(
      title: 'Today\'s Shift Timeline',
      accentColor: Colors.indigo,
      children: [
        TimelineItem(
          child: Text(
            '18:45 - ${localized.room("101")} - J. Doe - Tachycardia resolved',
            style: TextStyle(fontSize: isSmall ? 13 : 14),
          ),
        ),
        TimelineItem(
          child: Text(
            '18:30 - ${localized.room("103")} - M. Smith - Fall detected',
            style: TextStyle(fontSize: isSmall ? 13 : 14),
          ),
        ),
        TimelineItem(
          child: Text(
            '18:15 - ${localized.room("102")} - A. Johnson - Pain meds administered',
            style: TextStyle(fontSize: isSmall ? 13 : 14),
          ),
        ),
      ],
    );

    // Place alerts beside the timeline on desktop and stack them on smaller screens.
    if (isDesktop) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [alertsColumn],
            ),
          ),
          SizedBox(width: 12),
          Expanded(flex: 3, child: timelineWidget),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FractionallySizedBox(widthFactor: 1, child: alertsColumn),
        SizedBox(height: isSmall ? 8 : 12),
        FractionallySizedBox(widthFactor: 1, child: timelineWidget),
      ],
    );
  }
}
