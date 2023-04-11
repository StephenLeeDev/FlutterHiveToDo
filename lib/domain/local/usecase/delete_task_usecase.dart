import 'package:todo_hive/domain/local/repository/hive_repository.dart';

class DeleteTaskUseCase {
  final HiveRepository _hiveRepository;

  DeleteTaskUseCase({required HiveRepository hiveRepository})
      : _hiveRepository = hiveRepository;

  Future<void> execute({required key}) async {
    return await _hiveRepository.delete(key: key);
  }
}