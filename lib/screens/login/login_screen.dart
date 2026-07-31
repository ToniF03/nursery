import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/core/app_locale.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLoginSuccess});

  final VoidCallback onLoginSuccess;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                    labelText: AppLocalizations.of(context)!.username,
                    border: OutlineInputBorder(),
                  ),
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
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: textBoxWidth,
                child: ElevatedButton(
                  onPressed: () {
                    final String username = _usernameController.text.trim();
                    final String password = _passwordController.text.trim();

                    if (username.isNotEmpty && password.isNotEmpty) {
                      widget.onLoginSuccess();
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(AppLocalizations.of(context)!.fillBothFields),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.login,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
