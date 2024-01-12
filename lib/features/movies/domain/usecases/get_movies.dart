import 'package:vivavideos/core/error/error.dart';
import 'package:vivavideos/core/usecases/usecase.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';
import 'package:vivavideos/features/movies/domain/repositories/movies.repository.dart';

class GetMovies implements UseCase<Movies, NoParams> {
  const GetMovies(this.repository);
  final MoviesRepository repository;

  @override
  Future<(Movies?, Failure?)> call(NoParams params) async {
    return await repository.getMovies();
  }
}
