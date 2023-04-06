import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/repository/hive_repository.dart';

class ReadTaskUseCase {
  final HiveRepository _hiveRepository;

  ReadTaskUseCase(this._hiveRepository);

  Future<List<TaskModel>> execute() async {
    return await _hiveRepository.read();
  }
}