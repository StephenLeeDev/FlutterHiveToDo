import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/presentation/view/widget/home/task_widget.dart';
import 'package:todo_hive/presentation/viewmodel/task_viewmodel/task_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _showMyDialog(Function(String) createTask) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Task'),
          content: TextField(
            autofocus: true,
            onSubmitted: (String title) {
              createTask(title);
              Navigator.of(context).pop();
            },
            textInputAction: TextInputAction.done,
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TaskViewModel>().readTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To do')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMyDialog((title) {
            context
                .read<TaskViewModel>()
                .createTask(newTask: TaskModel(title: title));
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Selector<TaskViewModel, List<TaskModel>>(
        selector: (_, viewModel) => viewModel.taskList,
        builder: (context, tasks, _) {
          return ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            proxyDecorator:
                (Widget child, int index, Animation<double> animation) {
              return TaskWidget(
                index: index,
                taskModel: tasks[index],
              );
            },
            children: <Widget>[
              for (int index = 0; index < tasks.length; index += 1)
                Padding(
                  key: Key('$index'),
                  padding: const EdgeInsets.all(8.0),
                  child: TaskWidget(
                    index: index,
                    taskModel: tasks[index],
                  ),
                )
            ],
            onReorder: (int oldIndex, int newIndex) async {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              context.read<TaskViewModel>().setTaskList(
                  newList: await context
                      .read<TaskViewModel>()
                      .reorderTask(oldIndex: oldIndex, newIndex: newIndex));
            },
          );
        },
      ),
    );
  }
}
