import 'package:flutter/material.dart';
import 'package:nursery/app_layout_state.dart';
import 'package:nursery/screens/dashboard.dart';
import 'package:nursery/screens/login/login_screen.dart';
import 'l10n/app_localizations.dart';
import 'core/app_locale.dart';

void main() {
  runApp(const Nursery());
}

class Nursery extends StatelessWidget {
  const Nursery({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale?>(
      valueListenable: localeNotifier,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Nursery',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          home: const MyHomePage(title: 'nursery'),
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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedMobileIndex = 0;
  bool _isLoggedIn = false;

  Widget _buildSidebar() {
    return SizedBox(
      width: 240,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(30, 20, 16, 20),
          children: [
            Text(
              'Nursery',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                debugPrint('Dashboard tapped');
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Patients'),
              onTap: () {
                debugPrint('Patients tapped');
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_today),
              title: Text('Schedule'),
              onTap: () {
                debugPrint('Schedule tapped');
              },
            ),
            ListTile(
              leading: Icon(Icons.mail),
              title: Text('Messaging'),
              onTap: () {
                debugPrint('Messaging tapped');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool desktopLayout = constraints.maxWidth >= 900;
        setIsDesktop(desktopLayout);

        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (desktopLayout && _isLoggedIn) _buildSidebar(),

              Expanded(
                child: _isLoggedIn
                    ? Dashboard(
                        onLogout: () {
                          setState(() {
                            _isLoggedIn = false;
                          });
                        },
                      )
                    : LoginScreen(
                        onLoginSuccess: () {
                          setState(() {
                            _isLoggedIn = true;
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
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.people),
                      label: "Patients",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: 'Settings',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.contact_mail),
                      label: 'Contact Us',
                    ),
                  ],
                ),
        );
      },
    );
  }
}
