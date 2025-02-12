import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/login_controller.dart';

import '../../controller/sqflite_db.dart';
import '../../controller/task_controller.dart';
import 'lang_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SqfliteDb sqfliteDb = SqfliteDb();
  @override
  void initState() {
    sqfliteDb.intialDb();
    super.initState();

    Timer(Duration(seconds: 3), () {
      TaskController taskController =
          Provider.of<TaskController>(context, listen: false);
      Logincontrollerr logincontrollerr =
          Provider.of<Logincontrollerr>(context, listen: false);
      logincontrollerr.getAllUesrs();
      taskController.getAllTasks();
      taskController.getArchiveTask();
      taskController.getDoneTask();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LanguageSelectionScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.network(
            "https://thumbs.dreamstime.com/b/checklist-complete-task-icon-blue-color-checklist-complete-task-icon-beautiful-meticulously-designed-icon-well-organized-190950950.jpg"),
      ),
    );
  }
}
