import 'package:flutter/foundation.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/usecase/create_task_usecase.dart';
import 'package:todo_hive/domain/local/usecase/delete_task_usecase.dart';
import 'package:todo_hive/domain/local/usecase/read_task_usecase.dart';

class TaskViewModel extends ChangeNotifier {
  final CreateTaskUseCase _createTaskUseCase;
  final ReadTaskUseCase _readTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks => _tasks;

  TaskViewModel({
    required CreateTaskUseCase createTaskUseCase,
    required ReadTaskUseCase readTaskUseCase,
    required DeleteTaskUseCase deleteTaskUseCase,
  })  : _createTaskUseCase = createTaskUseCase,
        _readTaskUseCase = readTaskUseCase,
        _deleteTaskUseCase = deleteTaskUseCase;

  Future<void> createTask({required TaskModel newTask}) async {
    await _createTaskUseCase.execute(newTask: newTask);
  }

  Future<List<TaskModel>> readTaskList() async {
    _tasks = await _readTaskUseCase.execute();
    return _tasks;
  }

  void setUpdatedTask({required index, required updatedTask}) {
    _tasks.where((task) => task.key == updatedTask);
  }

  Future<void> deleteTask({required int key}) async {
    await _deleteTaskUseCase.execute(key: key);
  }

}