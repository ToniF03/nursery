import 'package:flutter/material.dart';
import 'package:nursery/screens/dashboard.dart';
import 'package:nursery/screens/login/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.onAuthStateChanged});

  final ValueChanged<bool> onAuthStateChanged;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onAuthStateChanged(
        Supabase.instance.client.auth.currentSession != null,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Supabase.instance.client.auth;

    return StreamBuilder<AuthState>(
      stream: auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? auth.currentSession;

        if (session != null) {
          return Dashboard(
            onLogout: () => widget.onAuthStateChanged(false),
          );
        }

        return LoginScreen(
          onLoginSuccess: () => widget.onAuthStateChanged(true),
        );
      },
    );
  }
}