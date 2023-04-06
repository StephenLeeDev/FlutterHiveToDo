import 'package:flutter/foundation.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/usecase/create_task_usecase.dart';
import 'package:todo_hive/domain/local/usecase/read_task_usecase.dart';

class TaskViewModel extends ChangeNotifier {

  final CreateTaskUseCase _createTaskUseCase;
  final ReadTaskUseCase _readTaskUseCase;

  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  TaskViewModel(
      {required CreateTaskUseCase createTaskUseCase, required ReadTaskUseCase readTaskUseCase})
      :
        _createTaskUseCase = createTaskUseCase,
        _readTaskUseCase = readTaskUseCase;

  Future<void> createTask({required TaskModel newTask}) async {
    await _createTaskUseCase.execute(newTask: newTask);
    readTaskList();
  }

  Future<void> readTaskList() async {
    _tasks = await _readTaskUseCase.execute();
    notifyListeners();
  }

}