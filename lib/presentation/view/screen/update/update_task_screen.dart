import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/presentation/view/widget/common/button/custom_elevated_button.dart';
import 'package:todo_hive/presentation/viewmodel/task_viewmodel/task_update_viewmodel.dart';
import 'package:todo_hive/presentation/viewmodel/task_viewmodel/task_viewmodel.dart';

class UpdateTaskScreen extends StatelessWidget {
  const UpdateTaskScreen({Key? key, required this.index, required this.task})
      : super(key: key);

  final int index;
  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    context.read<TaskUpdateViewModel>().setIndex(index: index);
    context.read<TaskUpdateViewModel>().setTask(taskModel: task);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update task",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Title"),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(
                        text: context
                            .read<TaskUpdateViewModel>()
                            .taskModel
                            .title),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'title',
                    ),
                    onChanged: (changedText) {
                      context
                          .read<TaskUpdateViewModel>()
                          .setTaskTitle(title: changedText);
                      context.read<TaskUpdateViewModel>().setIsValidForUpdate();
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text("Description"),
                  const SizedBox(height: 16),
                  TextField(
                    controller: TextEditingController(
                        text: context
                            .read<TaskUpdateViewModel>()
                            .taskModel
                            .description),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'description',
                    ),
                    onChanged: (changedText) {
                      context
                          .read<TaskUpdateViewModel>()
                          .setTaskDescription(description: changedText);
                      context.read<TaskUpdateViewModel>().setIsValidForUpdate();
                    },
                  ),
                ],
              ),
            ),
            Selector<TaskUpdateViewModel, bool>(
              selector: (context, viewModel) => viewModel.isValidForUpdate,
              builder: (context, isValidForUpdate, child) {
                return CustomElevatedButton(
                  onPressed: () {
                    if (isValidForUpdate) {
                      context.read<TaskUpdateViewModel>().updateTask();
                      context.read<TaskViewModel>().setUpdatedTask(
                          index: context.read<TaskUpdateViewModel>().index,
                          updatedTask:
                              context.read<TaskUpdateViewModel>().taskModel);
                      Navigator.pop(context, true);
                    } else {
                      null;
                    }
                  },
                  isEnabled: isValidForUpdate,
                  text: 'Update Confirm',
                );
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
