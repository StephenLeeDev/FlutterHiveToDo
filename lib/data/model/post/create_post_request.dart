import 'package:image_picker/image_picker.dart';


class CreatePostRequest {
  String? title;
  String? description;
  List<XFile>? images;

  CreatePostRequest({
    this.title,
    this.description,
    this.images,
  });

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) {
    return CreatePostRequest(
      title: json['title'],
      description: json['description'],
      images: _parseImages(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'images': _convertImagesToJson(),
    };
  }

  static List<XFile> _parseImages(List<dynamic> imagesJson) {
    return imagesJson.map((imagePath) => XFile(imagePath)).toList();
  }

  List<String>? _convertImagesToJson() {
    return images?.map((image) => image.path).toList();
  }
}