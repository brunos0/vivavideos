import 'package:vivavideos/features/movies/data/models/movies_model.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesModel?> getMovies();
}
