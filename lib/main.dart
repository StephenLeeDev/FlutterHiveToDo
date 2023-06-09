import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/data/model/task/task_model.dart';
import 'package:todo_hive/data/repository/local/task/hive_repository.dart';
import 'package:todo_hive/data/repository/remote/movie/movie_repository.dart';
import 'package:todo_hive/domain/usecase/movie/get_movie_list_usecase.dart';
import 'package:todo_hive/domain/usecase/task/create_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/delete_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/read_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/reorder_task_usecase.dart';
import 'package:todo_hive/domain/usecase/task/update_task_usecase.dart';
import 'package:todo_hive/presentation/router/router.dart';
import 'package:todo_hive/presentation/viewmodel/movie/list/movie_list_view_model.dart';
import 'package:todo_hive/presentation/viewmodel/task/list/task_list_viewmodel.dart';
import 'package:todo_hive/presentation/viewmodel/task/update/task_update_viewmodel.dart';

void main() async {

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await HiveRepositoryImpl().openBox();

  /// Task
  final hiveRepository = HiveRepositoryImpl();
  final readTaskUseCase = ReadTaskUseCase(hiveRepository: hiveRepository);
  final createTaskUseCase = CreateTaskUseCase(hiveRepository: hiveRepository);
  final updateTaskUseCase = UpdateTaskUseCase(hiveRepository: hiveRepository);
  final deleteTaskUseCase = DeleteTaskUseCase(hiveRepository: hiveRepository);
  final reorderTaskUseCase = ReorderTaskUseCase(hiveRepository: hiveRepository);
  final taskListViewModel = TaskListViewModel(
    createTaskUseCase: createTaskUseCase,
    readTaskUseCase: readTaskUseCase,
    deleteTaskUseCase: deleteTaskUseCase,
    reorderTaskUseCase: reorderTaskUseCase,
  );
  final taskUpdateViewModel = TaskUpdateViewModel(updateTaskUseCase: updateTaskUseCase);

  /// Movie
  final movieRepository = MovieRepositoryImpl();
  final getMovieListUseCase = GetMovieListUseCase(movieRepository: movieRepository);
  final movieListViewModel = MovieListViewModel(getMovieListUseCase: getMovieListUseCase);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskListViewModel>(
          create: (context) => taskListViewModel,
        ),
        ChangeNotifierProvider<TaskUpdateViewModel>(
          create: (context) => taskUpdateViewModel,
        ),
        ChangeNotifierProvider<MovieListViewModel>(
          create: (context) => movieListViewModel,
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
    return MaterialApp.router(
      routerConfig: router
    );
  }

}