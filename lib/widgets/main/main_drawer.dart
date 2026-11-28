import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/pill.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key, required this.onSelectedMobileIndex});

  final ValueChanged<int> onSelectedMobileIndex;

  @override
  State<MainDrawer> createState() => MainDrawerState();
}

class MainDrawerState extends State<MainDrawer> {
  bool isCollapsed = false;

  Widget _buildDrawerTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    String? pillText,
  }) {
    return Tooltip(
      message: isCollapsed ? label : '',
      child: ListTile(
        contentPadding: isCollapsed
            ? EdgeInsets.zero
            : const EdgeInsets.symmetric(horizontal: 12),
        leading: isCollapsed ? null : Icon(icon),
        title: isCollapsed
            ? Center(child: Icon(icon))
            : Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: isCollapsed || pillText == null ? null : Pill(text: pillText, color: const Color(0xFF3F4948)),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: isCollapsed ? 70 : 230,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            isCollapsed ? 11 : 15,
            20,
            isCollapsed ? 11 : 16,
            20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 25.2,
                child: SvgPicture.asset(
                  isCollapsed
                      ? 'assets/images/logo.svg'
                      : 'assets/images/title.svg',
                  width: 150,
                  height: 25.2,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildDrawerTile(
                      icon: Icons.dashboard,
                      label: l10n.dashboard,
                      onTap: () {
                        widget.onSelectedMobileIndex(0);
                        Navigator.of(
                          context,
                        ).popUntil((route) => route.isFirst);
                      },
                    ),
                    _buildDrawerTile(
                      icon: Icons.people,
                      label: l10n.patients,
                      pillText: '32',
                      onTap: () {
                        widget.onSelectedMobileIndex(1);
                        showDialog(
                          context: context,
                          builder: (context) => const NotImplementedDialog(),
                        );
                      },
                    ),
                    _buildDrawerTile(
                      icon: Icons.calendar_today,
                      label: l10n.schedule,
                      onTap: () {
                        widget.onSelectedMobileIndex(2);
                        showDialog(
                          context: context,
                          builder: (context) => const NotImplementedDialog(),
                        );
                      },
                    ),
                    _buildDrawerTile(
                      icon: Icons.mail_outline,
                      label: l10n.messaging,
                      pillText: '0',
                      onTap: () {
                        widget.onSelectedMobileIndex(3);
                        showDialog(
                          context: context,
                          builder: (context) => const NotImplementedDialog(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: isCollapsed
                    ? Alignment.center
                    : Alignment.centerLeft,
                child: Tooltip(
                  message: isCollapsed ? l10n.expand : l10n.collapse,
                  child: IconButton(
                    icon: Icon(
                      isCollapsed ? Icons.chevron_right : Icons.chevron_left,
                    ),
                    onPressed: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
