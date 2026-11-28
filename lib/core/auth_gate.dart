import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/globals.dart';
import 'package:nursery/screens/dashboard.dart';
import 'package:nursery/screens/login/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Routes between the dashboard and login screen based on the auth session.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key, required this.onAuthStateChanged});

  final ValueChanged<bool> onAuthStateChanged;

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  StreamSubscription<AuthState>? _authSubscription;
  String? _profileUserId;
  int _profileRequest = 0;
  bool _hasSyncedProfile = false;

  @override
  void initState() {
    super.initState();

    final auth = Supabase.instance.client.auth;
    _authSubscription = auth.onAuthStateChange.listen((authState) {
      _syncProfile(authState.session?.user);
    });
    _syncProfile(auth.currentUser);

    // Report the initial session after the first frame, when the parent is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      widget.onAuthStateChanged(auth.currentSession != null);
    });
  }

  void _syncProfile(User? user) {
    final userId = user?.id;
    if (_hasSyncedProfile && _profileUserId == userId) return;

    _hasSyncedProfile = true;
    _profileUserId = userId;
    final request = ++_profileRequest;
    final metadata = user?.userMetadata;
    final displayNameValue =
        metadata?['displayName'] ?? metadata?['display_name'];
    final displayName = displayNameValue is String
        ? displayNameValue.trim()
        : '';
    final metadataFirstName = displayName.isEmpty
        ? ''
        : displayName.split(RegExp(r'\s+')).first;

    Globals()
      ..currentUser = null
      ..userName = metadataFirstName.isEmpty ? null : metadataFirstName
      ..fullName = displayName.isEmpty ? null : displayName;
    if (mounted) setState(() {});

    if (userId != null && displayName.isEmpty) {
      _loadUserName(userId, request, displayName);
    }
  }

  Future<void> _loadUserName(
    String userId,
    int request,
    String metadataName,
  ) async {
    try {
      final supabase = Supabase.instance.client;
      final userData = await supabase
          .from('userData')
          .select('first_name, last_name')
          .eq('id', userId)
          .maybeSingle();

      if (!mounted ||
          request != _profileRequest ||
          supabase.auth.currentUser?.id != userId) {
        return;
      }

      final firstName = userData?['first_name'] as String? ?? '';
      final lastName = userData?['last_name'] as String? ?? '';
      final profileFirstName = firstName.trim();
      final profileFullName = '$firstName $lastName'.trim();
      Globals()
        ..currentUser = userData
        ..userName = profileFirstName.isEmpty
            ? (metadataName.isEmpty
                  ? null
                  : metadataName.split(RegExp(r'\s+')).first)
            : profileFirstName
        ..fullName = profileFullName.isEmpty
            ? (metadataName.isEmpty ? null : metadataName)
            : profileFullName;

      setState(() {});
    } catch (e) {
      debugPrint('Get Table Exception: $e');
    }
  }

  @override
  void dispose() {
    _profileRequest++;
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Supabase.instance.client.auth;

    // Authentication changes rebuild this gate and switch the visible screen.
    return StreamBuilder<AuthState>(
      stream: auth.onAuthStateChange,
      builder: (context, snapshot) {
        final session = snapshot.data?.session ?? auth.currentSession;

        if (session != null) {
          return const Dashboard();
        }

        return LoginScreen(
          onLoginSuccess: () => widget.onAuthStateChanged(true),
        );
      },
    );
  }
}
