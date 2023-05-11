import 'package:flutter/material.dart';
import 'package:todo_hive/data/model/movie/movie_model.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({Key? key, required this.movieModel}) : super(key: key);
  final MovieModel movieModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 100,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 15,
                offset: const Offset(10, 10),
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                child: Image.network(
                  movieModel.mediumCoverImage ?? "",
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return const SizedBox(
                        height: 100,
                        width: 65,
                        child: Icon(
                          Icons.image,
                          size: 60,
                          color: Colors.grey,
                        ),
                      );
                    }
                  },
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return const SizedBox(
                      height: 100,
                      width: 65,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 60,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movieModel.getTitleWithYearAndRating(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
