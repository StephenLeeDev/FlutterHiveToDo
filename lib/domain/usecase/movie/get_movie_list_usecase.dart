import 'package:todo_hive/data/model/movie/movie_list_data.dart';
import 'package:todo_hive/data/repository/remote/movie/movie_repository.dart';

class GetMovieListUseCase {
  final MovieRepository _movieRepository;

  GetMovieListUseCase({required MovieRepository movieRepository})
  : _movieRepository = movieRepository;

  Future<MovieListData?> execute({required int page, int perPage = 10}) async {
    return await _movieRepository.getMovieListByPageAndPerPage(page: page, perPage: perPage);
  }

}