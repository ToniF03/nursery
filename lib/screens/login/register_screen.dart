import 'dart:ui';

import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onLoginSuccess});

  final VoidCallback onLoginSuccess;

  @override
  State<RegisterPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterPage> {
  // Controllers collect organization, profile, and credential details.
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _organizationNameController =
      TextEditingController();

  final supabase = Supabase.instance.client;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> signUpWithEmail(
    String email,
    String password,
    String organization,
    String name,
  ) async {
    try {
      // Create the auth account and include the person's display name.
      await supabase.auth.signUp(
        email: email,
        password: password,
        data: {"displayName": name},
      );

      final userId = supabase.auth.currentSession!.user.id;
      // Store the organization separately in the application user profile.
      await supabase.from('userData').insert({
        "id": userId,
        'company': organization,
      });

      widget.onLoginSuccess();
      // IT DOES NOT REDIRECT CURRENTLY!
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
              SvgPicture.asset(
                'assets/images/logo_with_subtitle_transparent.svg',
                width: 384,
                height: 384,
              ),
              SizedBox(
                width: textBoxWidth,
                child: TextField(
                  controller: _organizationNameController,
                  decoration: const InputDecoration(
                    labelText: "Organization",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: textBoxWidth,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.name,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: textBoxWidth,
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.email,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: textBoxWidth,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: textBoxWidth,
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final String username = _usernameController.text.trim();
                        final String password = _passwordController.text.trim();
                        final String name = _nameController.text.trim();
                        final String organization = _organizationNameController
                            .text
                            .trim();

                        if (username.isNotEmpty &&
                            password.isNotEmpty &&
                            name.isNotEmpty &&
                            organization.isNotEmpty) {
                          signUpWithEmail(
                            username,
                            password,
                            organization,
                            name,
                          );
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
                      child: Text(AppLocalizations.of(context)!.register),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(AppLocalizations.of(context)!.loginInstead),
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
