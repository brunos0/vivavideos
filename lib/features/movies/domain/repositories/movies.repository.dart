import 'package:vivavideos/core/error/error.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';

abstract class MoviesRepository {
  MoviesRepository();

  Future<(Movies?, Failure?)> getMovies();
}
