import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/data/model/task/task_model.dart';
import 'package:todo_hive/data/repository/local/hive_repository.dart';
import 'package:todo_hive/domain/usecase/task/create_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/delete_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/read_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/reorder_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/update_task_usecase.dart';
import 'package:todo_hive/presentation/router/router.dart';
import 'package:todo_hive/presentation/viewmodel/update/task_update_viewmodel.dart';
import 'package:todo_hive/presentation/viewmodel/task_viewmodel/task_viewmodel.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await HiveRepositoryImpl().openBox();

  final hiveRepository = HiveRepositoryImpl();
  final readTaskUseCase = ReadTaskUseCase(hiveRepository: hiveRepository);
  final createTaskUseCase = CreateTaskUseCase(hiveRepository: hiveRepository);
  final updateTaskUseCase = UpdateTaskUseCase(hiveRepository: hiveRepository);
  final deleteTaskUseCase = DeleteTaskUseCase(hiveRepository: hiveRepository);
  final reorderTaskUseCase = ReorderTaskUseCase(hiveRepository: hiveRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskViewModel>(
          create: (context) => TaskViewModel(
            createTaskUseCase: createTaskUseCase,
            readTaskUseCase: readTaskUseCase,
            deleteTaskUseCase: deleteTaskUseCase,
            reorderTaskUseCase: reorderTaskUseCase,
          ),
        ),
        ChangeNotifierProvider<TaskUpdateViewModel>(
          create: (context) => TaskUpdateViewModel(
            updateTaskUseCase: updateTaskUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

// Changed Something

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router
    );
  }
}