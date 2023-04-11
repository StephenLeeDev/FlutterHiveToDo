import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/repository/hive_repository.dart';
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
              setState(() {});
              Navigator.of(context).pop();
            },
            textInputAction: TextInputAction.done,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);
    return FutureBuilder<List<TaskModel>>(
      future: taskViewModel.readTaskList(),
      builder: (context, snapshot) {
        List<TaskModel> tasks = snapshot.data ?? [];

        return Scaffold(
          appBar: AppBar(title: const Text('To do')),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showMyDialog((title) {
                taskViewModel.createTask(newTask: TaskModel(title: title));
              });
            },
          ),
          body: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            proxyDecorator:
                (Widget child, int index, Animation<double> animation) {
              return TaskWidget(
                  task: tasks[index],
                  onDeleted: () async {
                    await taskViewModel.deleteTask(key: tasks[index].key);
                    setState(() {});
                  });
            },
            children: <Widget>[
              for (int index = 0; index < tasks.length; index += 1)
                Padding(
                  key: Key('$index'),
                  padding: const EdgeInsets.all(8.0),
                  child: TaskWidget(
                    task: tasks[index],
                    onDeleted: () async {
                      await taskViewModel.deleteTask(key: tasks[index].key);
                      setState(() {});
                    },
                  ),
                )
            ],
            onReorder: (int oldIndex, int newIndex) async {

              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              await HiveRepositoryImpl().reorder(oldIndex: oldIndex, newIndex: newIndex);
              setState(() {});
            },
          ),
        );
      },
    );
  }
}