/* spell-checker: disable */

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vivavideos/core/error/exceptions.dart';
import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:vivavideos/features/movies/data/models/movies_model.dart';
import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
//import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
//import 'package:vivavideos/features/movies/domain/entities/movies.dart';

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  const MoviesRemoteDataSourceImpl({required this.client});

  final http.Client client;

  @override
  Future<MoviesModel?> getMovies() async {
    final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/discover/movie'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmOGM5NzNiY2FhYzg0NzkyZGQ0NDBhMTZkMjgwNzcyNyIsInN1YiI6IjY1OWViMDkzYjM5ZTM1MDFhNjlkNGM2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MZrj8eRqkCXysrC54GQGuH2Tl2jfRuFWOWQoutY0jXc'
        });
    if (response.statusCode == 200) {
      return (MoviesModel.fromJson(json.decode(response.body)));
    } else {
      throw (ServerException());
    }
  }
}
