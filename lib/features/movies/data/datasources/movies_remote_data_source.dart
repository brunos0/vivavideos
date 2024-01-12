import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';

abstract class MoviesRemoteDataSource {
  Future<(Movies?, Failure?)> getMovies();
}
