import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:todo/view/screens/login_screen.dart';
import 'package:todo/view/widgets/custom_alert_dialog_widget.dart';
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
      drawer: Drawer(
        child: ListView(children: [
          DrawerHeader(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: Container(
              color: const Color.fromARGB(255, 197, 171, 161),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Language"),
            subtitle: Text("Choose your Language"),
            // trailing: Icon(Icons.login_outlined),
            onTap: () {
              showSignUpDoneDialog(context);

              setState(() {});
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("LogOut"),
            subtitle: Text("Cart Sub title"),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPageScreen()));
              setState(() {});
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("About Me"),
            subtitle: Text("More info about developer team"),
          ),
        ]),
      ),
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

  showSignUpDoneDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialogWidget(
          title: "Choose Your Language",
          backgroundColor: Colors.green,
          text1: AppLocalizations.of(context)!.en,
          onPressed1: () {
            Provider.of<LocaleController>(context, listen: false)
                .changeLang(langCode: "en");
            Navigator.pop(context);
          },
          text2: AppLocalizations.of(context)!.ar,
          onPressed2: () {
            Provider.of<LocaleController>(context, listen: false)
                .changeLang(langCode: "ar");
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
