/* spell-checker: disable */

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:vivavideos/features/movies/data/models/movies_model.dart';
//import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
//import 'package:vivavideos/features/movies/domain/entities/movies.dart';

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  const MoviesRemoteDataSourceImpl({required this.client});

  final http.Client client;
  @override
  Future<(MoviesModel?, Failure?)> getMovies() async {
    final response = await client.get(
        Uri.parse('https://api.themoviedb.org/3/discover/movie'),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmOGM5NzNiY2FhYzg0NzkyZGQ0NDBhMTZkMjgwNzcyNyIsInN1YiI6IjY1OWViMDkzYjM5ZTM1MDFhNjlkNGM2NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MZrj8eRqkCXysrC54GQGuH2Tl2jfRuFWOWQoutY0jXc'
        });
    return (MoviesModel.fromJson(json.decode(response.body)), null);
    /*
    return const (
      MoviesModel(movies: [
        MovieItem(
            originalTitle: 'The Family Plan',
            overview:
                'Dan Morgan is many things: a devoted husband, a loving father, a celebrated car salesman. Hes also a former assassin. And when his past catches up to his present, hes forced to take his unsuspecting family on a road trip unlike any other.',
            urlCover: '/a6syn9qcU4a54Lmi3JoIr1XvhFU.jpg')
      ]),
      null
    );
    */
  }
}
