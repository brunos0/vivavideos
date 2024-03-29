import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vivavideos/features/movies/data/models/movies_model.dart';
import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../fixtures/mocked_movies.dart' as mocked_movies;
import '../../../../fixtures/mocked_movies_model.dart' as mocked_movies_model;

const List<MovieItem> movies = [
  MovieItem(
      originalTitle: 'titanic', overview: 'E afundou', urlCover: 'teste.jpeg'),
];

void main() {
  MoviesModel tMoviesModel = mocked_movies.movies;
  Map mockedMoviesModel = mocked_movies_model.result;

  final Map<String, dynamic> jsonMap = json.decode(fixture('movies.json'));
  test('should be a subclass of Movie entity', () async {
    // assert
    expect(tMoviesModel, isA<Movies>());
  });

  group('fromJson', () {
    test('should return a valid model when the Json is getter', () async {
      //  arrange

      //  act
      final result = MoviesModel.fromJson(jsonMap);
      //  assert
      expect(result.movies.first, tMoviesModel.movies.first);
    });
  });

  group('toJson', () {
    test('should return a json map containing the proper data', () async {
      //  act
      final result = tMoviesModel.toJson();
      //  assert
      expect(result, mockedMoviesModel);
    });
  });
}
