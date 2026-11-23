import 'package:flutter/material.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/quick_action_button.dart';
import 'package:nursery/widgets/horizontal_fade_list.dart';

class DashboardQuickActions extends StatelessWidget {
  const DashboardQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isSmall ? 8 : 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              AppLocalizations.of(context)!.quickActions,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: isSmall ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: isSmall ? 8 : 12),
          HorizontalFadeList(
            children: [
              QuickActionButton(
                icon: Icons.medication,
                label: AppLocalizations.of(context)!.logMeds,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
              QuickActionButton(
                icon: Icons.monitor_heart_outlined,
                label: AppLocalizations.of(context)!.recordVitals,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
              QuickActionButton(
                icon: Icons.swap_horiz,
                label: AppLocalizations.of(context)!.patientTransfer,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
              QuickActionButton(
                icon: Icons.insert_drive_file_outlined,
                label: AppLocalizations.of(context)!.reportIncident,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
              QuickActionButton(
                icon: Icons.message_outlined,
                label: AppLocalizations.of(context)!.contactPhysician,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
              QuickActionButton(
                icon: Icons.emergency_rounded,
                label: AppLocalizations.of(context)!.codeBlue,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
              QuickActionButton(
                icon: Icons.add,
                label: AppLocalizations.of(context)!.customize,
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
    );
  }
}
