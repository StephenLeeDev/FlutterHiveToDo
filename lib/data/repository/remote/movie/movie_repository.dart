import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_hive/data/model/movie/movie_list_data.dart';
import 'package:todo_hive/data/model/movie/movie_list_response.dart';

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

      debugPrint('url : $url');
      debugPrint('response : ${response.data}');
      debugPrint("");

      return movieListResponse.data;
    }
    return null;
  }

}