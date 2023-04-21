import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  bool isFinished;

  TaskModel({required this.title, this.description = "", this.isFinished = false});

  TaskModel copy() {
    return TaskModel(title: title, description: description, isFinished: isFinished);
  }

  @override
  String toString() {
    return "TaskModel(title: $title, content: $description, finished: $isFinished)";
  }

  @override
  bool operator ==(Object other) {
    if (other is! TaskModel) return false;
    if (title != other.title) return false;
    if (description != other.description) return false;
    if (isFinished != other.isFinished) return false;
    return true;
  }

  @override
  int get hashCode {
    return title.hashCode ^ description.hashCode ^ isFinished.hashCode;
  }

}