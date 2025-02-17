// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constant.dart';
import 'package:todo/model/task_model.dart';

import '../../controller/task_controller.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel taskModel;
  const TaskWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    TaskController taskController =
        Provider.of<TaskController>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: Constant.gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: const Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              // رسالة المهمة
              Text(
                taskModel.msg ?? "No message", // تأكد من أن الرسالة ليست null
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.done,
                      size: 28,
                    ),
                    color: taskModel.done == true ? Colors.green : Colors.white,
                    onPressed: () async {
                      await taskController.updateTaskToDone(
                        userId: taskController.userModel!.id,
                        done: taskModel.done!,
                        id: taskModel.id!,
                      );

                      print(
                          " =========================== OnPressd Done ${taskController.userModel!.id}");
                    },
                    splashRadius: 24,
                  ),
                  IconButton(
                    icon: Icon(
                      taskModel.archive == true
                          ? Icons.unarchive
                          : Icons.archive,
                      size: 28,
                    ),
                    color:
                        taskModel.archive == true ? Colors.amber : Colors.white,
                    onPressed: () async {
                      await taskController.updateTaskToArchive(
                        userId: taskController.userModel!.id,
                        id: taskModel.id!,
                        archive: taskModel.archive!,
                      );
                      print(
                          " =========================== OnPressd Archive ${taskController.userModel!.id}");
                    },
                    splashRadius: 24,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 28,
                    ),
                    color: Colors.redAccent,
                    onPressed: () {
                      taskController.deleteTask(
                          userId: taskController.userModel!.id,
                          id: taskModel.id!);
                      print(
                          " =========================== OnPressd Delete ${taskController.userModel!.id}");
                    },
                    splashRadius: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
