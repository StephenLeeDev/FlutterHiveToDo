import 'package:todo_hive/data/model/movie/movie_list_data.dart';
import 'package:dio/dio.dart';
import 'package:todo_hive/data/model/movie/movie_list_response.dart';
import 'package:todo_hive/presentation/util/log/log_util.dart';

abstract class MovieRepository {
  Future<MovieListData?> getMovieListByPageAndPerPage({required int page, required int perPage});
}

class MovieRepositoryImpl extends MovieRepository {

  static const baseUrl = 'https://yts.torrentbay.net/api/v2/list_movies.json';
  final dio = Dio();

  @override
  Future<MovieListData?> getMovieListByPageAndPerPage({required int page, required int perPage}) async {
    final url = '$baseUrl?page=$page&limit=$perPage';
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final MovieListResponse movieListResponse = MovieListResponse.fromJson(response.data);

      printOnDebug('url : $url');
      printOnDebug('response : ${response.data}');

      return movieListResponse.data;
    }
    return null;
  }

}