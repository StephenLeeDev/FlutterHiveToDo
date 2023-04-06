import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive/data/model/task_model.dart';

const String TASK_BOX = 'TASK_BOX';

abstract class HiveRepository {
  Future openBox();
  Future create({required TaskModel newTask});
  Future<List<TaskModel>> read();
  Future update(int index, TaskModel updatedTask);
  Future delete({required int index});
  Future reorder({required int oldIndex, required int newIndex});
}

class HiveRepositoryImpl extends HiveRepository {
  static final HiveRepositoryImpl _singleton = HiveRepositoryImpl._internal();

  factory HiveRepositoryImpl() {
    return _singleton;
  }

  HiveRepositoryImpl._internal();

  Box<TaskModel>? taskBox;

  @override
  Future openBox() async {
    taskBox = await Hive.openBox(TASK_BOX);
  }

  @override
  Future create({required TaskModel newTask}) async {
    if (kDebugMode) {
      print("create function has ran");
    }
    return await taskBox?.add(newTask);
  }

  @override
  Future<List<TaskModel>> read() async {
    List<TaskModel> list = taskBox?.values.toList() ?? [];
    if (kDebugMode) {
      print("read function has ran");
    }
    return list;
  }

  @override
  Future update(int index, TaskModel updatedTask) async {
    if (kDebugMode) {
      print("update function has ran");
    }
    await taskBox?.putAt(index, updatedTask);
  }

  @override
  Future delete({required int index}) async {
    if (kDebugMode) {
      print("delete function has ran");
    }
    await taskBox?.delete(index);
  }

  @override
  Future reorder({required int oldIndex, required int newIndex}) async {
    if (kDebugMode) {
      print("reorder function has ran");
    }
    List<TaskModel> newList = taskBox?.values.toList() ?? [];

    final TaskModel task = newList.removeAt(oldIndex);
    newList.insert(newIndex, task);

    await taskBox?.clear();
    await taskBox?.addAll(newList);

    return;
  }

}
