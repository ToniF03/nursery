import 'package:flutter/material.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/user_button.dart';

class DashboardTopBar extends StatefulWidget {
  const DashboardTopBar({super.key});

  @override
  State<DashboardTopBar> createState() => _DashboardTopBarState();
}

class _DashboardTopBarState extends State<DashboardTopBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // Cancel active timers and controllers before this state is removed.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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

        // Notification buttons.
        IconButton(
          icon: Icon(
            Icons.notifications,
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
        const SizedBox(width: 12),

        // User account button opens the user menu page.
        UserButton(),
      ],
    );
  }
}
