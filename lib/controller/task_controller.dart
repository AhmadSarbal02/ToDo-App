import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';

// ignore: depend_on_referenced_packages

import '../view/widgets/alert_dialog_widget.dart';
import 'sqflite_db.dart';

class TaskController extends ChangeNotifier {
  SqfliteDb sqfliteDb = SqfliteDb();

  List<TaskModel> listTasks = [];
  List<TaskModel> listDoneTasks = [];
  List<TaskModel> listArciveTask = [];

  getAllTasks() async {
    listTasks = [];
    List<Map> listData = await sqfliteDb.getData(
        sql: 'SELECT * FROM task WHERE done = 0 AND archive = 0');
    for (Map i in listData) {
      listTasks.add(TaskModel.fromjson(json: i));
    }
    notifyListeners();
  }

  getDoneTask() async {
    listDoneTasks = [];
    List<Map> listData =
        await sqfliteDb.getData(sql: 'SELECT * FROM task WHERE done = 1');
    for (Map i in listData) {
      listDoneTasks.add(TaskModel.fromjson(json: i));
    }
    notifyListeners();
  }

  getArchiveTask() async {
    listArciveTask = [];
    List<Map> listData =
        await sqfliteDb.getData(sql: 'SELECT * FROM task WHERE archive = 1');
    for (Map i in listData) {
      listArciveTask.add(TaskModel.fromjson(json: i));
    }
    notifyListeners();
  }

  insertTask({required String msg}) async {
    await sqfliteDb.insertData(
        sql:
            'INSERT INTO task (msg, done, archive) VALUES ("$msg", FALSE, FALSE)');
    getAllTasks();
  }

  updateTask({required String msg, required int id}) async {
    await sqfliteDb.updateData(
        sql: 'Update task SET msg = "$msg" Where id ="$id"');
    getAllTasks();
    notifyListeners();
  }

  updateTaskToDone({required bool done, required int id}) async {
    await sqfliteDb.updateData(
        sql:
            'Update task SET done = ${!done ? 1 : 0}, archive = 0 Where id ="$id"');
    await getDoneTask();
    await getAllTasks();
    await getArchiveTask();
    notifyListeners();
  }

  updateTaskToArchive({required bool archive, required int id}) async {
    await sqfliteDb.updateData(
        sql:
            'UPDATE task SET archive = ${!archive ? 1 : 0}, done = 0 WHERE id = "$id"');
    await getDoneTask();
    await getAllTasks();
    await getArchiveTask();
    notifyListeners();
  }

  deleteTask({required int id}) async {
    await sqfliteDb.deleteData(sql: 'DELETE FROM task WHERE id = "$id"');
    await getDoneTask();
    await getAllTasks();
    await getArchiveTask();
  }

  showAddTaskDialog(BuildContext context) async {
    TextEditingController? controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // استخدام السمة الحالية للتطبيق
        return CustomTaskDialog(
            title: "New Task",
            controller: controller,
            onSubmit: () {
              Provider.of<TaskController>(context, listen: false)
                  .insertTask(msg: controller.text);
              Navigator.of(context).pop();
            });
      },
    );
  }

  showUpdateTaskDialog(BuildContext context, TaskModel taskmodel) async {
    TextEditingController? controller = TextEditingController();
    controller.text = taskmodel.msg!;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomTaskDialog(
            title: "Update Task",
            controller: controller,
            onSubmit: () {
              Provider.of<TaskController>(context, listen: false)
                  .updateTask(msg: controller.text, id: taskmodel.id!);
              Navigator.of(context).pop();
            });
      },
    );
  }
}
