import 'package:material_ui/material_ui.dart';
import 'package:nursery/core/app_layout_state.dart';
import 'package:nursery/widgets/not_implemented_dialog.dart';
import 'package:nursery/widgets/pill.dart';

class DashboardPriorityPatientsTable extends StatelessWidget {
  const DashboardPriorityPatientsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isSmall ? 8.0 : 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(isSmall ? 8.0 : 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Priority Patients',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    child: const Text('View All'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const NotImplementedDialog(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const ColoredBox(
            color: Color(0xFFF1F1F1),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                children: [
                  Expanded(flex: 3, child: Text('PATIENT & ROOM')),
                  Expanded(flex: 2, child: Text('STATUS')),
                  Expanded(child: Text('SPO2')),
                  Expanded(child: Text('PULSE')),
                  Expanded(child: Text('TEMP')),
                  Expanded(
                    flex: 2,
                    child: Text('LAST SYNC', textAlign: TextAlign.end),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.white,
            clipBehavior: Clip.antiAlias,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12.0),
              bottomRight: Radius.circular(12.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 3; i++) ...[
                  if (i > 0)
                    const Divider(height: 1, thickness: 1, color: Color(0xFFF1F1F1)),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const NotImplementedDialog(),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(flex: 3, child: Text('John Doe - Room 101')),
                          Expanded(
                            flex: 2,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Pill(text: 'Critical', color: Colors.red),
                            ),
                          ),
                          Expanded(child: Text('92%')),
                          Expanded(child: Text('110 BPM')),
                          Expanded(child: Text('37.5°C')),
                          Expanded(
                            flex: 2,
                            child: Text(
                              '10 mins ago',
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}