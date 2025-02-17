import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/login_controller.dart';

import '../../controller/task_controller.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/task_widget.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TaskController>(
        builder: (context, taskController, child) {
          // إذا كانت المهام فارغة، عرض شاشة بلا مهام
          if (taskController.listTasks.isEmpty) {
            return NoTaskWidget();
          } else {
            // إذا كانت هناك مهام، عرضها في شبكة
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0, // مسافة بين الأعمدة
                mainAxisSpacing: 8.0, // مسافة بين الصفوف
              ),
              itemCount: taskController.listTasks.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  taskController.showUpdateTaskDialog(
                    userId: taskController.userModel!.id,
                    context,
                    taskController.listTasks[index],
                  );
                },
                child: TaskWidget(
                  taskModel: taskController.listTasks[index],
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: Consumer<TaskController>(
        builder: (context, taskController, child) => FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            taskController.showAddTaskDialog(context);
          },
          child: const Icon(
            Icons.add_task,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
