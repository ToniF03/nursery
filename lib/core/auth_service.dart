import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final SupabaseClient _supabase = Supabase.instance.client;

  Future<void> signOut() {
    return _supabase.auth.signOut();
  }

  VoidCallback? onLogout;
}
