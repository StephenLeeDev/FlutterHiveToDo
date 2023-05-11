import 'package:todo_hive/data/model/movie/movie_model.dart';

class MovieListData {
  MovieListData({
    this.movieCount,
    this.limit,
    this.pageNumber,
    this.movies,});

  MovieListData.fromJson(dynamic json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = [];
      json['movies'].forEach((v) {
        movies?.add(MovieModel.fromJson(v));
      });
    }
  }
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<MovieModel>? movies;

  bool hasNext() {
    return (movieCount ?? 0) > (movies?.length ?? 0);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_count'] = movieCount;
    map['limit'] = limit;
    map['page_number'] = pageNumber;
    map['movies'] = movies?.map((v) => v.toJson()).toList();
    return map;
  }

}
