import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String title;
  @HiveField(1)
  bool finished;

  TaskModel({required this.title, this.finished = false});

  @override
  String toString() {
    return "TaskModel(title: $title, finished: $finished)";
  }
}