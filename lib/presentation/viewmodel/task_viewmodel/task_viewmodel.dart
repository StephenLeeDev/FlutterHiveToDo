import 'package:flutter/foundation.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/usecase/create_task_usecase.dart';
import 'package:todo_hive/domain/local/usecase/delete_task_usecase.dart';
import 'package:todo_hive/domain/local/usecase/read_task_usecase.dart';

class TaskViewModel extends ChangeNotifier {
  final CreateTaskUseCase _createTaskUseCase;
  final ReadTaskUseCase _readTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  List<TaskModel> _taskList = [];

  List<TaskModel> get taskList => _taskList;

  TaskViewModel({
    required CreateTaskUseCase createTaskUseCase,
    required ReadTaskUseCase readTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
  })  : _createTaskUseCase = createTaskUseCase,
        _readTaskUseCase = readTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase;

  Future<void> createTask({required TaskModel newTask}) async {
    await _createTaskUseCase.execute(newTask: newTask);
    addTaskToTaskList(newTask: newTask);
  }

  void addTaskToTaskList({required TaskModel newTask}) {
    setTaskList(newList: [...taskList, newTask]);
  }

  void setTaskList({required List<TaskModel> newList}) {
    _taskList = newList;
    notifyListeners();
  }

  Future readTaskList() async {
    setTaskList(newList: await _readTaskUseCase.execute());
  }

  void setUpdatedTask({required index, required updatedTask}) {
    var newList = taskList.toList();
    newList[index] = updatedTask;
    setTaskList(newList: newList);
  }

  Future<void> deleteTask({required int index, required int key}) async {
    await _deleteTaskUseCase.execute(key: key);
    var newList = taskList.toList();
    if (newList.length - 1 >= index) newList.removeAt(index);
    setTaskList(newList: newList);
  }

}