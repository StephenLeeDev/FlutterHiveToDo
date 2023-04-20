import 'package:flutter/material.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/usecase/update_task_usecase.dart';

/// This ViewModel is for update task screen
class TaskUpdateViewModel extends ChangeNotifier {
  final UpdateTaskUseCase _updateTaskUseCase;

  late TaskModel _taskModel;
  TaskModel get taskModel => _taskModel;

  late TaskModel _originalTaskModel;
  TaskModel get originalTaskModel => _originalTaskModel;

  bool _isValidForUpdate = false;
  bool get isValidForUpdate => _isValidForUpdate;

  TaskUpdateViewModel({
    required UpdateTaskUseCase updateTaskUseCase,
  }) : _updateTaskUseCase = updateTaskUseCase;

  void setTask({required TaskModel taskModel}) {
    _taskModel = taskModel.copy();
    setOriginalTask(taskModel: taskModel.copy());
    setTaskTitle(title: taskModel.copy().title);
    setTaskDescription(description: taskModel.copy().description);
    initIsValidForUpdate();
  }

  void setTaskTitle({required String title}) {
    _taskModel.title = title;
  }

  void setTaskDescription({required String description}) {
    _taskModel.description = description;
  }

  void setIsValidForUpdate() {
    _isValidForUpdate = originalTaskModel != taskModel && taskModel.title.isNotEmpty;
    notifyListeners();
  }

  void initIsValidForUpdate() {
    _isValidForUpdate = false;
  }

  void setOriginalTask({required TaskModel taskModel}) {
    _originalTaskModel = taskModel;
  }

  Future<void> updateTask({required int index}) async {
    await _updateTaskUseCase.execute(index: index, updatedTask: taskModel);
  }

  Future<void> updateTaskByParameter({required int index, required TaskModel updatedTask}) async {
    await _updateTaskUseCase.execute(index: index, updatedTask: updatedTask);
  }

}
