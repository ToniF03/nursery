import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/screens/login/register_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLoginSuccess});

  final VoidCallback onLoginSuccess;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Input controllers keep credential values for submit and validation.
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final supabase = Supabase.instance.client;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      // Supabase validates credentials and establishes the active session.
      await supabase.auth.signInWithPassword(email: email, password: password);

      widget.onLoginSuccess();
    } on AuthException catch (e) {
      debugPrint('Auth-Exception: ${e.message}');
      _showErrorSnackBar(e.message);
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      _showErrorSnackBar(e.toString());
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Limit form width while allowing it to fill most narrow screens.
    final textBoxWidth = clampDouble(
      MediaQuery.sizeOf(context).width * 0.8,
      0,
      400,
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Branded login header.
              Image.asset(
                'assets/images/logo_with_subtitle.png',
                width: 384,
                height: 384,
                fit: BoxFit.contain,
              ),
              SizedBox(
                width: textBoxWidth,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (String value) {
                    final String username = _usernameController.text.trim();
                    final String password = _passwordController.text.trim();

                    if (username.isNotEmpty && password.isNotEmpty) {
                      signInWithEmail(username, password);
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.fillBothFields,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: textBoxWidth,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (String value) {
                    final String username = _usernameController.text.trim();
                    final String password = _passwordController.text.trim();

                    if (username.isNotEmpty && password.isNotEmpty) {
                      signInWithEmail(username, password);
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.fillBothFields,
                        ),
                      ),
                    );
                  },
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              // Login and organization-registration actions.
              SizedBox(
                width: textBoxWidth,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final String username = _usernameController.text.trim();
                        final String password = _passwordController.text.trim();

                        if (username.isNotEmpty && password.isNotEmpty) {
                          signInWithEmail(username, password);
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.fillBothFields,
                            ),
                          ),
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.login),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(
                              onLoginSuccess: widget.onLoginSuccess,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.joinAsOrganization,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
