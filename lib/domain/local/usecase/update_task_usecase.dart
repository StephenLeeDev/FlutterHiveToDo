import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/repository/hive_repository.dart';

class UpdateTaskUseCase {
  final HiveRepository _hiveRepository;

  UpdateTaskUseCase({required HiveRepository hiveRepository})
      : _hiveRepository = hiveRepository;

  Future<void> execute({required int index, required TaskModel updatedTask}) async {
    return await _hiveRepository.update(index: index, updatedTask: updatedTask);
  }
}