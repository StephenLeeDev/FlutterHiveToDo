import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:todo_hive/data/model/task/task_model.dart';
import 'package:todo_hive/presentation/util/log/log_util.dart';

const String TASK_BOX = 'TASK_BOX';

abstract class HiveRepository {
  Future openBox();
  Future create({required TaskModel newTask});
  Future<List<TaskModel>> read();
  Future update({required int index, required TaskModel updatedTask});
  Future delete({required int key});
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
    printOnDebug("create function has ran with new task ${newTask.toString()}");
    return await taskBox?.add(newTask);
  }

  @override
  Future<List<TaskModel>> read() async {
    List<TaskModel> list = taskBox?.values.toList() ?? [];
    printOnDebug("read function has ran");
    if (kDebugMode) {
      for (var index = 0; index < list.length; index++) {
        printOnDebug("$index : ${list[index].toString()}, key : ${list[index].key}");
      }
    }
    return list;
  }

  @override
  Future update({required int index, required TaskModel updatedTask}) async {
    printOnDebug("update function has ran with index : $index");
    await taskBox?.putAt(index, updatedTask);
  }

  @override
  Future delete({required int key}) async {
    printOnDebug("delete function has ran with key : $key");
    printOnDebug("taskBox.isNull : ${taskBox == null}");
    await taskBox?.delete(key);
  }

  @override
  Future<List<TaskModel>> reorder({required int oldIndex, required int newIndex}) async {
    printOnDebug("reorder function has ran with reordered index : $oldIndex => $newIndex");
    List<TaskModel> newList = taskBox?.values.toList() ?? [];

    final TaskModel task = newList.removeAt(oldIndex);
    newList.insert(newIndex, task);

    await taskBox?.clear();
    await taskBox?.addAll(newList);

    return newList;
  }

}
