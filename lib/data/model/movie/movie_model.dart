import 'dart:ffi';

class MovieModel {
  MovieModel({
    this.id,
    this.url,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.language,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.dateUploaded,});

  MovieModel.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    year = json['year'];
    if (json['rating'] is Double) {
      rating = json['rating'];
    } else if (json['rating'] is int) {
      rating = json['rating'].toDouble();
    } else {
      rating = null;
    }
    runtime = json['runtime'];
    genres = json['genres'] != null ? json['genres'].cast<String>() : [];
    summary = json['summary'];
    descriptionFull = json['description_full'];
    language = json['language'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    state = json['state'];
    dateUploaded = json['date_uploaded'];
  }
  int? id;
  String? url;
  String? title;
  String? titleEnglish;
  String? titleLong;
  int? year;
  double? rating;
  int? runtime;
  List<String>? genres;
  String? summary;
  String? descriptionFull;
  String? language;
  String? smallCoverImage;
  String? mediumCoverImage;
  String? largeCoverImage;
  String? state;
  String? dateUploaded;

  String getTitleWithYearAndRating() {
    String yearString = year != null ? '($year)' : '';
    String ratingString = rating != null && rating != 0.0 ? ' $rating' : '';
    return "$title$yearString $ratingString";
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['title'] = title;
    map['title_english'] = titleEnglish;
    map['title_long'] = titleLong;
    map['year'] = year;
    map['rating'] = rating;
    map['runtime'] = runtime;
    map['genres'] = genres;
    map['summary'] = summary;
    map['description_full'] = descriptionFull;
    map['language'] = language;
    map['small_cover_image'] = smallCoverImage;
    map['medium_cover_image'] = mediumCoverImage;
    map['large_cover_image'] = largeCoverImage;
    map['state'] = state;
    map['date_uploaded'] = dateUploaded;
    return map;
  }

}
