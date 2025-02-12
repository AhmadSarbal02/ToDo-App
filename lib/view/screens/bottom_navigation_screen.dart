import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../controller/locale_controller.dart';
import 'archive_task_screen.dart';
import 'done_tasks_screen.dart';
import 'tasks_screen.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int currentIndex = 0;
  //screens List
  List<Widget> screens = const [
    TasksScreen(),
    DoneTasksScreen(),
    ArchiveTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    //titles List
    List<String> titles = [
      AppLocalizations.of(context)!.tasks,
      AppLocalizations.of(context)!.donetasks,
      AppLocalizations.of(context)!.archivetask,
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          titles[currentIndex],
          style: const TextStyle(color: Colors.white),
        ),

        //Locale Change Button
        actions: [
          // EN Button
          TextButton(
              onPressed: () {
                Provider.of<LocaleController>(context, listen: false)
                    .changeLang(langCode: "en");
              },
              child: Text(
                AppLocalizations.of(context)!.en,
                style: const TextStyle(color: Colors.white),
              )),
          //AR Buttonn
          TextButton(
              onPressed: () {
                Provider.of<LocaleController>(context, listen: false)
                    .changeLang(langCode: "ar");
              },
              child: Text(
                AppLocalizations.of(context)!.ar,
                style: const TextStyle(color: Colors.white),
              )),
        ],
      ),

      body: screens[currentIndex],

      //BottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            currentIndex = value;
            setState(() {});
          },
          currentIndex: currentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          items: [
            BottomNavigationBarItem(
                icon: const Icon(Icons.menu),
                label: AppLocalizations.of(context)!.tasks),
            BottomNavigationBarItem(
                icon: const Icon(Icons.done_all_outlined),
                label: AppLocalizations.of(context)!.done),
            BottomNavigationBarItem(
                icon: const Icon(Icons.archive_outlined),
                label: AppLocalizations.of(context)!.archive),
          ]),
    );
  }
}
