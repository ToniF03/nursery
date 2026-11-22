import 'package:flutter/material.dart';
import 'package:nursery/core/logout_helper.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Displays the signed-in user's account menu and navigation options.
class UserMenuPage extends StatefulWidget {
  const UserMenuPage({super.key});

  @override
  State<UserMenuPage> createState() => _UserMenuPage();
}

class _UserMenuPage extends State<UserMenuPage> {
  // Supabase client used for profile lookup and logout.
  final supabase = Supabase.instance.client;
  String name = '';

  @override
  void initState() {
    super.initState();
    // Load the user's display name when the menu opens.
    getUserName();
  }

  void navigateToFirst() {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> getUserName() async {
    try {
      final userId = supabase.auth.currentUser?.id;
      if (userId == null) return;

      final userData = await supabase
          .from('userData')
          .select('first_name, last_name')
          .eq('id', userId)
          .maybeSingle();

      if (!mounted) return;
      setState(() {
        final firstName = userData?['first_name'] as String? ?? '';
        final lastName = userData?['last_name'] as String? ?? '';
        name = '$firstName $lastName'.trim();
      });
    } catch (e) {
      debugPrint('Get Table Exception: $e');
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
                  children: [
                    const Icon(Icons.account_circle, size: 50),
                    const SizedBox(width: 10),
                    Text(name, style: const TextStyle(fontSize: 25.0)),
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
                        logoutAndNavigate(context);
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
