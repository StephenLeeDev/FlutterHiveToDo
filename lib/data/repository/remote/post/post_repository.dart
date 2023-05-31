import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:todo_hive/data/model/post/create_post_request.dart';

import '../../../model/post/post_model.dart';

abstract class PostRepository {
  Future<PostModel?> postCreateNewPost({required CreatePostRequest createPostRequest});
}

class PostRepositoryImpl extends PostRepository {

  static const baseUrl = 'http://192.168.1.251:3001';
  final dio = Dio();

  @override
  Future<PostModel?> postCreateNewPost({required CreatePostRequest createPostRequest}) async {
    final url = '$baseUrl/post/upload';

    List<Future<MultipartFile>>? imageFiles = createPostRequest.images?.map((image) => MultipartFile.fromFile(image.path)).toList();
    final List<MultipartFile> images = await Future.wait(imageFiles ?? []);

    final formData = FormData.fromMap({
      'title': createPostRequest.title,
      'description': createPostRequest.description,
      // 'images': images,
      'files': images,
    });

    dio.options.contentType = 'multipart/form-data';
    dio.options.headers = {
      'Authorization': "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpvaG5AZ21haWwuY29tIiwiaWF0IjoxNjg1NDQ0NTQyLCJleHAiOjE2ODY3NTg1NDJ9.1TnsbS-GJustml_lvxO81-9c0bbsucF48LkjI8lkBFo",
      'token': "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImpvaG5AZ21haWwuY29tIiwiaWF0IjoxNjg1NDQ0NTQyLCJleHAiOjE2ODY3NTg1NDJ9.1TnsbS-GJustml_lvxO81-9c0bbsucF48LkjI8lkBFo",
    };

    debugPrint('title : ${createPostRequest.title}');
    debugPrint('description : ${createPostRequest.description}');
    debugPrint('createPostRequest : ${createPostRequest.toString()}');

    try {
      final response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        final postModel = PostModel.fromJson(response.data);

        debugPrint('url : $url');
        debugPrint('response : ${response.data}');
        debugPrint('');

        return postModel;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }

}