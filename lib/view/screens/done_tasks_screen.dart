import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/task_controller.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/task_widget.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<TaskController>(builder: (context, taskController, child) {
        if (taskController.listDoneTasks.isEmpty) {
          return NoTaskWidget();
        } else {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: taskController.listDoneTasks.length,
            itemBuilder: (context, index) => TaskWidget(
              taskModel: taskController.listDoneTasks[index],
            ),
          );
        }
      }),
    );
  }
}
