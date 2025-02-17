import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constant.dart';

import '../../controller/task_controller.dart';
import '../widgets/no_task_widget.dart';
import '../widgets/task_widget.dart';

class ArchiveTaskScreen extends StatelessWidget {
  const ArchiveTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.background,
      body: Consumer<TaskController>(builder: (context, taskController, child) {
        if (taskController.listArciveTask.isEmpty) {
          return NoTaskWidget();
        } else {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: taskController.listArciveTask.length,
            itemBuilder: (context, index) => TaskWidget(
              taskModel: taskController.listArciveTask[index],
            ),
          );
        }
      }),
    );
  }
}
