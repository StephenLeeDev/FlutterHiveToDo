import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/domain/local/repository/hive_repository.dart';
import 'package:todo_hive/data/model/task_model.dart';
import 'package:todo_hive/domain/local/usecase/create_task_usecase.dart';
import 'package:todo_hive/domain/local/usecase/read_task_usecase.dart';
import 'package:todo_hive/presentation/view/screen/home/home_screen.dart';
import 'package:todo_hive/presentation/viewmodel/task_viewmodel/task_viewmodel.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await HiveRepositoryImpl().openBox();

  final hiveRepository = HiveRepositoryImpl();
  final readTaskUseCase = ReadTaskUseCase(hiveRepository: hiveRepository);
  final createTaskUseCase = CreateTaskUseCase(hiveRepository: hiveRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskViewModel>(
          create: (context) => TaskViewModel(
              createTaskUseCase: createTaskUseCase,
              readTaskUseCase: readTaskUseCase),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
