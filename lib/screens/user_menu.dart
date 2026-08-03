import 'package:flutter/material.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserMenuPage extends StatefulWidget {
  final VoidCallback onLogout;
  const UserMenuPage({super.key, required this.onLogout});

  @override
  State<UserMenuPage> createState() => _UserMenuPage();
}

class _UserMenuPage extends State<UserMenuPage> {
  final supabase = Supabase.instance.client;

  void navigateToFirst() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> logOut() async {
    try {
      await supabase.auth.signOut();
      navigateToFirst();
      widget.onLogout();
    } catch (e) {
      debugPrint('Logout Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                debugPrint('User header tapped');
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: const [
                    Icon(Icons.account_circle, size: 50),
                    SizedBox(width: 10),
                    Text('Toni Fey', style: TextStyle(fontSize: 25.0)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.calendar_month),
                      title: Text(AppLocalizations.of(context)!.shiftPlan),
                      onTap: () {
                        debugPrint('Dashboard tapped');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: Text(AppLocalizations.of(context)!.notifications),
                      onTap: () {
                        debugPrint('Dashboard tapped');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.support),
                      title: Text(AppLocalizations.of(context)!.helpCenter),
                      onTap: () {
                        debugPrint('Help Center tapped');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: Text(AppLocalizations.of(context)!.settings),
                      onTap: () {
                        debugPrint('Settings tapped');
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: Text(AppLocalizations.of(context)!.logout),
                      onTap: () {
                        logOut();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
