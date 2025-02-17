import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/constant.dart';
import 'package:todo/controller/login_controller.dart' show Logincontrollerr;
import 'package:todo/controller/task_controller.dart';

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
  void initState() {
    var taskController = Provider.of<TaskController>(context, listen: false);
    var logincontroller = Provider.of<Logincontrollerr>(context, listen: false);
    taskController.userModel = logincontroller.userModel!;
    taskController.getAllTasks(userId: taskController.userModel!.id);
    taskController.getArchiveTask(userId: taskController.userModel!.id);
    taskController.getDoneTask(userId: taskController.userModel!.id);
    super.initState();
  }

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
        backgroundColor: Constant.background,
        child: ListView(children: [
          DrawerHeader(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            child: Container(
              decoration: BoxDecoration(gradient: Constant.gradient),
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
          const ListTile(
            leading: Icon(Icons.person),
            title: Text("About Me"),
            subtitle: Text("More info about developer team"),
          ),
        ]),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(gradient: Constant.gradient),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              titles[currentIndex],
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
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
          backgroundColor: const Color.fromARGB(255, 200, 211, 255),
          selectedItemColor: const Color.fromARGB(255, 41, 79, 231),
          selectedIconTheme: IconThemeData(
            size: 30,
          ),
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
    return await showDialog(
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
