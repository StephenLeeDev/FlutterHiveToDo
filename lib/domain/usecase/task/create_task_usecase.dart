import 'package:todo_hive/data/model/task/task_model.dart';
import 'package:todo_hive/data/repository/local/task/hive_repository.dart';

class CreateTaskUseCase {
  final HiveRepository _hiveRepository;

  CreateTaskUseCase({required HiveRepository hiveRepository})
      : _hiveRepository = hiveRepository;

  Future<void> execute({required TaskModel newTask}) async {
    return await _hiveRepository.create(newTask: newTask);
  }
}
