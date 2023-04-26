import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_hive/data/model/movie/movie_model.dart';
import 'package:todo_hive/presentation/view/widget/movie/movie_widget.dart';
import 'package:todo_hive/presentation/viewmodel/movie/list/movie_list_view_model.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    context.read<MovieListViewModel>().getMovieList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Selector<MovieListViewModel, List<MovieModel>>(
        selector: (_, viewModel) => viewModel.movieList,
        builder: (context, movieList, _) {
          return ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(
                  8, MediaQuery.of(context).padding.top, 8, 8),
              itemCount: movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: MovieWidget(
                    movieModel: movieList[index],
                  ),
                );
              }, separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20),
          );
        },
      ),
    );
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter == 0) {
      context.read<MovieListViewModel>().getMovieList();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
