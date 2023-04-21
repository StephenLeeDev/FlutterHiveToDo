import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/data/model/task/task_model.dart';
import 'package:todo_hive/presentation/view/screen/update/update_task_screen.dart';
import 'package:todo_hive/presentation/viewmodel/task_viewmodel/task_viewmodel.dart';
import 'package:todo_hive/presentation/viewmodel/update/task_update_viewmodel.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.index,
    required this.taskModel,
  }) : super(key: key);

  final int index;
  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color evenItemColor = colorScheme.primary;

    return Material(
      child: Selector<TaskViewModel, TaskModel>(
        selector: (_, viewModel) => viewModel.taskList[index],
        builder: (context, task, _) {
          var taskItem = task.copy();
          return AnimatedContainer(
            constraints: const BoxConstraints(minHeight: 60),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: taskItem.isFinished ? Colors.grey : evenItemColor,
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            child: Row(
              children: [
                Checkbox(
                  key: key,
                  value: taskItem.isFinished,
                  onChanged: (checked) async {
                    if (checked != null) {
                      taskItem.isFinished = checked;
                    }
                    taskItem.isFinished = checked ?? false;

                    await context
                        .read<TaskUpdateViewModel>()
                        .updateTaskByParameter(
                            index: index, updatedTask: taskItem);

                    if (context.mounted) {
                      context
                          .read<TaskViewModel>()
                          .setUpdatedTask(index: index, updatedTask: taskItem);
                    }
                  },
                ),
                Expanded(
                  child: Text(
                    taskItem.title,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      decoration: taskItem.isFinished
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateTaskScreen(index: index, task: taskItem),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  onPressed: () async => await context
                      .read<TaskViewModel>()
                      .deleteTask(index: index, key: task.key),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
