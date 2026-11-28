import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/auth_service.dart';
import 'package:nursery/core/globals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> logoutAndNavigate(BuildContext context) async {
  try {
    await AuthService.instance.signOut();

    Globals().currentUser = null;
    Globals().userName = null;
    Globals().fullName = null;

    if (!context.mounted) return;

    Navigator.of(context).popUntil((route) => route.isFirst);
  } on AuthException catch (e) {
    debugPrint('Logout Exception: ${e.message}');
  }
}
