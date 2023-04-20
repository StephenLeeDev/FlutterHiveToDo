import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/repository/hive_repository.dart';

class ReorderTaskUseCase {
  ReorderTaskUseCase({required HiveRepository hiveRepository})
      : _hiveRepository = hiveRepository;

  final HiveRepository _hiveRepository;

  Future<List<TaskModel>> execute({required int oldIndex, required int newIndex}) async {
    return await _hiveRepository.reorder(oldIndex: oldIndex, newIndex: newIndex);
  }

}
