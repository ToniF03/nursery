import 'package:flutter/material.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/core/logout_helper.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/screens/user_menu.dart';

class UserButton extends StatelessWidget {
  const UserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.account_circle,
        size: isSmall ? 20 : 25,
        color: Colors.grey,
      ),
      onPressed: () {
        if (isDesktop) {
          final RenderBox button = context.findRenderObject()! as RenderBox;
          final RenderBox overlay =
              Navigator.of(context).overlay!.context.findRenderObject()!
                  as RenderBox;

          final Offset topLeft = button.localToGlobal(
            Offset.zero,
            ancestor: overlay,
          );
          final Offset bottomRight = button.localToGlobal(
            button.size.bottomRight(Offset.zero),
            ancestor: overlay,
          );

          final RelativeRect position = RelativeRect.fromLTRB(
            topLeft.dx,
            bottomRight.dy,
            overlay.size.width - bottomRight.dx,
            overlay.size.height - bottomRight.dy,
          );

          showMenu<String>(
            context: context,
            position: position,
            items: [
              PopupMenuItem(
                value: 'shiftPlan',
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.shiftPlan),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'helpCenter',
                child: Row(
                  children: [
                    Icon(Icons.help),
                    SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.helpCenter),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings),
                    SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.settings),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(width: 10),
                    Text(AppLocalizations.of(context)!.logout),
                  ],
                ),
              ),
            ],
          ).then((value) {
            if (value != null) {
              switch (value) {
                case 'logout':
                  logoutAndNavigate(context);
                  break;
              }
            }
          });
        } else {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => UserMenuPage()));
        }
      },
    );
  }
}
