import 'package:todo_hive/data/model/task/task_model.dart';
import 'package:todo_hive/data/repository/local/hive_repository.dart';

class ReadTaskUseCase {
  final HiveRepository _hiveRepository;

  ReadTaskUseCase({required HiveRepository hiveRepository})
      : _hiveRepository = hiveRepository;

  Future<List<TaskModel>> execute() async {
    return await _hiveRepository.read();
  }
}