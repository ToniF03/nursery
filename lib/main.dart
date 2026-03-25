import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nursery',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'nursery'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedMobileIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  static const List<String> _mobileSections = [
    'Dashboard',
    'Patients',
    'Schedule',
    'Messaging',
  ];

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
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 900;

        final content = Padding(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              if (!isDesktop)
                Text(
                  _mobileSections[_selectedMobileIndex],
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (!isDesktop) const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      enabled: true,
                      readOnly: false,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.indigo,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F3F5),
                        hintText: 'Search for patients, schedules, or messages',
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Icon(Icons.notifications, size: 25, color: Colors.grey),
                  const Icon(Icons.notifications, size: 25, color: Colors.grey),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Good morning, Toni',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Card(
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                      },
                      child: const SizedBox(
                        width: 120,
                        height: 50,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.people, size: 30),
                              SizedBox(width: 6),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'STAFF RATIO',
                                    style: TextStyle(
                                      fontSize: 7.5,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '1:3',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

        return Scaffold(
          body: Row(
            children: [
              if (isDesktop) _buildSidebar(),
              Expanded(child: content),
            ],
          ),
          bottomNavigationBar: isDesktop
              ? null
              : BottomNavigationBar(
                  currentIndex: _selectedMobileIndex,
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
