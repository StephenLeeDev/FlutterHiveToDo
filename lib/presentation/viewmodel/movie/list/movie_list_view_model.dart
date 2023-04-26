import 'package:flutter/foundation.dart';
import 'package:todo_hive/data/model/movie/movie_list_data.dart';
import 'package:todo_hive/data/model/movie/movie_model.dart';
import 'package:todo_hive/domain/usecase/movie/get_movie_list_usecase.dart';
import 'package:todo_hive/presentation/util/log/log_util.dart';

class MovieListViewModel extends ChangeNotifier {
  final GetMovieListUseCase _getMovieListUseCase;

  MovieListViewModel({
    required GetMovieListUseCase getMovieListUseCase,
  }) : _getMovieListUseCase = getMovieListUseCase;

  List<MovieModel> _movieList = [];
  List<MovieModel> get movieList => _movieList;

  late MovieListData? _movieListData;
  MovieListData? get movieListData => _movieListData;

  int _page = 1;
  int get page => _page;

  final int _perPage = 10;
  int get perPage => _perPage;

  bool _hasNext = true;
  bool get hasNext => _hasNext;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getMovieList() async {
    if (isLoading || !hasNext) return;
    setIsLoading(true);

    _movieListData = await _getMovieListUseCase.execute(page: page, perPage: perPage);

    if (_movieListData != null) {
      pageIncrement();
      addNewMoviesToList(newMovies: _movieListData?.movies ?? []);
      setHasNext(_movieListData?.hasNext() ?? false);
    }
    setIsLoading(false);
    printOnDebug('movieList.length() : ${movieList.length}');
  }

  void addNewMoviesToList({required List<MovieModel> newMovies}) {
    setMovieList(newList: [...movieList, ...newMovies]);
  }

  void setMovieList({required List<MovieModel> newList}) {
    _movieList = newList;
    notifyListeners();
  }

  void pageIncrement() {
    ++_page;
  }

  void setHasNext(bool hasNext) {
    _hasNext = hasNext;
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
  }

}
