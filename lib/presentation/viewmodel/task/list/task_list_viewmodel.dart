import 'package:flutter/foundation.dart';
import 'package:todo_hive/data/model/task/task_model.dart';
import 'package:todo_hive/domain/usecase/task/create_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/delete_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/read_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/reorder_task_usecase.dart';

class TaskListViewModel extends ChangeNotifier {
  final CreateTaskUseCase _createTaskUseCase;
  final ReadTaskUseCase _readTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;
  final ReorderTaskUseCase _reorderTaskUseCase;

  List<TaskModel> _taskList = [];

  List<TaskModel> get taskList => _taskList;

  TaskListViewModel({
    required CreateTaskUseCase createTaskUseCase,
    required ReadTaskUseCase readTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
    required ReorderTaskUseCase reorderTaskUseCase,
  })  : _createTaskUseCase = createTaskUseCase,
        _readTaskUseCase = readTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase,
        _reorderTaskUseCase = reorderTaskUseCase;

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

  Future<List<TaskModel>> reorderTask({required int oldIndex, required int newIndex}) async {
    return await _reorderTaskUseCase.execute(oldIndex: oldIndex, newIndex: newIndex);
  }

}
