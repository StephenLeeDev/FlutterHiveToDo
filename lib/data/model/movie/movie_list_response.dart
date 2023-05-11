import 'package:todo_hive/data/model/movie/movie_list_data.dart';

class MovieListResponse {
  MovieListResponse({
    this.status,
    this.statusMessage,
    this.data,});

  MovieListResponse.fromJson(dynamic json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? MovieListData.fromJson(json['data']) : null;
  }
  String? status;
  String? statusMessage;
  MovieListData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['status_message'] = statusMessage;
    map['data'] = data?.toJson();
    return map;
  }

}