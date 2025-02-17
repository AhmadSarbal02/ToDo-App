// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/model/user_model.dart';

// ignore: depend_on_referenced_packages

import '../view/widgets/alert_dialog_widget.dart';
import 'sqflite_db.dart';

class TaskController extends ChangeNotifier {
  SqfliteDb sqfliteDb = SqfliteDb();
  UserModel? userModel;

  List<TaskModel> listTasks = [];
  List<TaskModel> listDoneTasks = [];
  List<TaskModel> listArciveTask = [];

  getAllTasks({required int userId}) async {
    listTasks = [];
    print(
        "============================= userModel in Task controller = ${userModel!.email}");
    print("============================= userId in Task controller = $userId");
    try {
      List<Map> listData = await sqfliteDb.getData(
          sql:
              'SELECT * FROM task WHERE user_id = $userId AND done = 0 AND archive = 0');
      if (listData.isNotEmpty) {
        for (Map i in listData) {
          listTasks.add(TaskModel.fromjson(json: i));
        }
      } else {
        print(
            " ================================= ⚠️ لم يتم العثور على مهام للمستخدم $userId");
      }
      notifyListeners();
    } catch (e) {
      print(" ====================== Error get tasks $e");
    }
  }

  getDoneTask({required int userId}) async {
    listDoneTasks = [];
    try {
      List<Map> listData = await sqfliteDb.getData(
          sql: 'SELECT * FROM task WHERE user_id = $userId AND done = 1');

      for (Map i in listData) {
        listDoneTasks.add(TaskModel.fromjson(json: i));
      }
    } catch (e) {
      print("================== $e");
    }

    notifyListeners();
  }

  getArchiveTask({required int userId}) async {
    listArciveTask = [];
    List<Map> listData = await sqfliteDb.getData(
        sql: 'SELECT * FROM task WHERE user_id = $userId AND archive = 1');
    for (Map i in listData) {
      listArciveTask.add(TaskModel.fromjson(json: i));
    }

    notifyListeners();
  }

  insertTask({required String msg}) async {
    try {
      int userId = userModel!.id; // احصل على userId من المستخدم الحالي

      print("🔍 إدراج مهمة جديدة للمستخدم: $userId - الرسالة: $msg");

      await sqfliteDb.insertData(
          sql:
              'INSERT INTO task (user_id, msg, done, archive) VALUES ($userId, "$msg", 0, 0)');

      print("✅ تمت إضافة المهمة بنجاح!");
    } catch (e) {
      print("❌ خطأ أثناء إضافة المهمة: $e");
    }
    await getAllTasks(userId: userModel!.id);
    notifyListeners();
  }

  updateTask(
      {required String msg, required int id, required int userId}) async {
    await sqfliteDb.updateData(
        sql:
            'Update task SET msg = "$msg" Where id =$id AND user_id = $userId');
    await getAllTasks(userId: userId);
    await getDoneTask(userId: userId);
    await getArchiveTask(userId: userId);
    notifyListeners();
  }

  updateTaskToDone(
      {required bool done, required int id, required int userId}) async {
    try {
      await sqfliteDb.updateData(
          sql:
              'Update task SET done = ${!done ? 1 : 0}, archive = 0 Where id = $id AND user_id = $userId');
    } catch (e) {
      print("====================== updateTaskToDone error = $e");
    }
    await getAllTasks(userId: userId);
    await getDoneTask(userId: userId);
    await getArchiveTask(userId: userId);
    notifyListeners();
  }

  updateTaskToArchive(
      {required bool archive, required int id, required int userId}) async {
    await sqfliteDb.updateData(
        sql:
            'UPDATE task SET archive = ${!archive ? 1 : 0}, done = 0 WHERE id = $id AND user_id = $userId');
    await getAllTasks(userId: userId);
    await getDoneTask(userId: userId);
    await getArchiveTask(userId: userId);
    notifyListeners();
  }

  deleteTask({required int id, required int userId}) async {
    await sqfliteDb.deleteData(
        sql: 'DELETE FROM task WHERE id = $id AND user_id = $userId');
    await getAllTasks(userId: userId);
    await getDoneTask(userId: userId);
    await getArchiveTask(userId: userId);
    notifyListeners();
  }

  showAddTaskDialog(BuildContext context) async {
    TextEditingController? controller = TextEditingController();
    return await showDialog(
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

  showUpdateTaskDialog(BuildContext context, TaskModel taskmodel,
      {required int userId}) async {
    TextEditingController? controller = TextEditingController();
    controller.text = taskmodel.msg!;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomTaskDialog(
            title: "Update Task",
            controller: controller,
            onSubmit: () {
              Provider.of<TaskController>(context, listen: false).updateTask(
                  msg: controller.text, id: taskmodel.id!, userId: userId);
              Navigator.of(context).pop();
            });
      },
    );
  }
}
