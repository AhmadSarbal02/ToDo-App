import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/controller/task_controller.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/task_widget.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TaskController>(builder: (context, taskController, child) {
        if (taskController.listTasks.isEmpty) {
          return NoTaskWidget();
        } else {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: taskController.listTasks.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                taskController.showUpdateTaskDialog(
                    context, taskController.listTasks[index]);
              },
              child: TaskWidget(
                taskModel: taskController.listTasks[index],
              ),
            ),
          );
        }
      }),
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
