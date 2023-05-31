import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_hive/data/model/post/create_post_request.dart';

import '../../../../data/repository/remote/post/post_repository.dart';
import '../../widget/common/button/custom_elevated_button.dart';

class UploadImageScreen extends StatefulWidget {

  static const String routeName = "upload";
  static const String routeURL = "/upload";

  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  List<XFile> imageList = [];
  final postRepository = PostRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            CustomElevatedButton(
                onPressed: () async {
                  var picker = ImagePicker();
                  var pickedImage = await picker.pickImage(source: ImageSource.gallery);

                  if (pickedImage != null) {
                    imageList.add(pickedImage);

                    postRepository.postCreateNewPost(
                        createPostRequest: CreatePostRequest(
                            title: "title image uploading test",
                            description: "description image uploading test",
                            images: imageList
                        )
                    );
                    imageList = [];
                  }
                },
                text: 'Pick Image',
              ),
          ],
        ),
      ),
    );
  }
}
