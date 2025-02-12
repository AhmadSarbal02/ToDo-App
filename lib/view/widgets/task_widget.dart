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
              offset: Offset(4, 4),
              blurRadius: 8,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              // رسالة المهمة
              Text(
                taskModel.msg!,
                textAlign: TextAlign.center,
                style: TextStyle(
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
                    icon: Icon(
                      Icons.done,
                      size: 28,
                    ),
                    color: taskModel.done == true ? Colors.green : Colors.white,
                    onPressed: () async {
                      await taskController.updateTaskToDone(
                        done: taskModel.done!,
                        id: taskModel.id!,
                      );
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
                        id: taskModel.id!,
                        archive: taskModel.archive!,
                      );
                    },
                    splashRadius: 24,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      size: 28,
                    ),
                    color: Colors.redAccent,
                    onPressed: () {
                      taskController.deleteTask(id: taskModel.id!);
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
