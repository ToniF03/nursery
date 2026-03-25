import 'package:flutter/material.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
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
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 25,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  size: 25,
                  color: Colors.grey,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => const NotImplementedDialog(),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: const Text(
                    'Good morning, Toni',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Card(
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const NotImplementedDialog(),
                      );
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
          ),
        ],
      ),
    );
  }
}
