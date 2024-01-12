import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';
//import 'dart:convert';
//import 'package:vivavideos/core/util/fixture.dart';

class MoviesModel extends Movies {
  const MoviesModel({required List<MovieItem> movies}) : super(movies: movies);

  factory MoviesModel.fromJson(Map<String, dynamic> json) {
    List<MovieItem> movies = [];

    final List<dynamic> jsonList = json['results'];
    int listSize = jsonList.length;

    for (int i = 0; i < listSize; i++) {
      movies.add(MovieItem(
          originalTitle:
              '${jsonList[i]['original_title'].replaceAll('\'', '')}',
          overview: '${jsonList[i]['overview'].replaceAll('\'', '')}',
          urlCover: '${jsonList[i]['poster_path']}'));
    }

    return MoviesModel(movies: movies);
  }

  Map<String, List<Map<String, String>>> toJson() {
    List<Map<String, String>> moveItem = [];

    int listSize = movies.length;

    for (int i = 0; i < listSize; i++) {
      moveItem.add(
        {
          "originalTitle": movies[i].originalTitle,
          "overview": movies[i].overview,
          "urlCover": movies[i].urlCover
        },
      );
    }
    return {"result": moveItem};
  }
}
