import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/widgets/dashboard/dashboard_info_bar.dart';
import 'package:nursery/widgets/dashboard/dashboard_priority_patients_table.dart';
import 'package:nursery/widgets/dashboard/dashboard_quick_actions.dart';
import 'package:nursery/widgets/dashboard/dashboard_top_bar.dart';
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

            const DashboardInfoBar(),

            const DashboardQuickActions(),

            const DashboardPriorityPatientsTable(),
          ],
        ),
      ),
    );
  }
}
