import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constant.dart';
import 'package:todo/controller/login_controller.dart';

import '../../controller/task_controller.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/task_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.background,
      body: Consumer<TaskController>(
        builder: (context, taskController, child) {
          // إذا كانت المهام فارغة، عرض شاشة بلا مهام
          if (taskController.listTasks.isEmpty) {
            return NoTaskWidget();
          } else {
            // إذا كانت هناك مهام، عرضها في شبكة
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          backgroundColor: const Color.fromARGB(255, 41, 79, 231),
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
