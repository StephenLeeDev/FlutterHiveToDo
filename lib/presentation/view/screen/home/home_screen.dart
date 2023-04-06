import 'package:flutter/material.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/repository/hive_repository.dart';
import 'package:todo_hive/presentation/view/widget/home/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Task'),
          content: TextField(
            autofocus: true,
            onSubmitted: (String text) {
              HiveRepositoryImpl().create(newTask: TaskModel(title: text));
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
    return FutureBuilder<List<TaskModel>>(
      future: HiveRepositoryImpl().read(),
      builder: (context, snapshot) {
        List<TaskModel> tasks = snapshot.data ?? [];

        return Scaffold(
          appBar: AppBar(title: const Text('To do')),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showMyDialog();
            },
          ),
          body: ReorderableListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            proxyDecorator:
                (Widget child, int index, Animation<double> animation) {
              return TaskWidget(task: tasks[index], onDeleted: () {});
            },
            children: <Widget>[
              for (int index = 0; index < tasks.length; index += 1)
                Padding(
                  key: Key('$index'),
                  padding: const EdgeInsets.all(8.0),
                  child: TaskWidget(
                    task: tasks[index],
                    onDeleted: () {
                      setState(() {
                        HiveRepositoryImpl().delete(index: index);
                      });
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