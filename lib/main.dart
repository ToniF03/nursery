import 'dart:async';
import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/core/app_locale.dart';
import 'package:nursery/core/auth_gate.dart';
import 'package:nursery/l10n/app_localizations.dart';
import 'package:nursery/widgets/main/main_drawer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Initialize Supabase before Flutter builds and listens for auth changes.
  await Supabase.initialize(
    url: 'https://djdwliacvcxwvulgnkxl.supabase.co',
    publishableKey: 'sb_publishable_r7gSbJX0_fkmdadEa7bcWw_i71Yu11i',
  );
  runApp(const Nursery());
}

class Nursery extends StatelessWidget {
  const Nursery({super.key});
  static const Color primaryColor = Color(0xFF4A9B9B);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Rebuild MaterialApp whenever the app locale changes.
    return ValueListenableBuilder<Locale?>(
      valueListenable: localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Nursery',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
            splashColor: primaryColor.withAlpha(76),
            highlightColor: primaryColor.withAlpha(25),
            hoverColor: primaryColor.withAlpha(13),
            focusColor: primaryColor.withAlpha(31),
            scaffoldBackgroundColor: const Color(0xffF5F5F5),
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          home: const MyHomePage(),
          locale: locale,
          // If the device locale is not supported, always fall back to English.
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            if (deviceLocale != null) {
              for (final supported in supportedLocales) {
                if (supported.languageCode == deviceLocale.languageCode) {
                  return supported;
                }
              }
            }
            return const Locale('en');
          },
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Tracks the mobile tab, login status, and auth stream subscription.
  int _selectedMobileIndex = 0;
  bool _isLoggedIn = false;
  StreamSubscription<AuthState>? _authSubscription;

  @override
  void initState() {
    super.initState();

    // Seed login state from the current session and keep it synchronized.
    final auth = Supabase.instance.client.auth;
    _isLoggedIn = auth.currentSession != null;
    _authSubscription = auth.onAuthStateChange.listen((authState) {
      final isLoggedIn = authState.session != null;
      if (_isLoggedIn == isLoggedIn || !mounted) return;

      setState(() {
        _isLoggedIn = isLoggedIn;
      });
    });
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Desktop navigation starts at 900 pixels of available width.
        final bool desktopLayout = constraints.maxWidth >= 900;
        final bool smallLayout = constraints.maxWidth < 600;
        setIsDesktop(desktopLayout);
        setIsSmall(smallLayout);

        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (desktopLayout && _isLoggedIn)
                MainDrawer(
                  onSelectedMobileIndex: (index) {
                    setState(() {
                      _selectedMobileIndex = index;
                    });
                  },
                ),

              Expanded(
                child: AuthGate(
                  onAuthStateChanged: (value) {
                    if (_isLoggedIn == value) return;
                    setState(() {
                      _isLoggedIn = value;
                    });
                  },
                ),
              ),
            ],
          ),

          bottomNavigationBar: desktopLayout || !_isLoggedIn
              ? null
              : BottomNavigationBar(
                  currentIndex: _selectedMobileIndex,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  onTap: (index) {
                    setState(() {
                      _selectedMobileIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.dashboard),
                      label: AppLocalizations.of(context)!.dashboard,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.people),
                      label: AppLocalizations.of(context)!.patients,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.calendar_today),
                      label: AppLocalizations.of(context)!.schedule,
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.mail_outline),
                      label: AppLocalizations.of(context)!.messaging,
                    ),
                  ],
                ),
        );
      },
    );
  }
}
