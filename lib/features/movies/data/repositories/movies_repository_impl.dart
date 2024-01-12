import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/core/platform/network_info.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';
import 'package:vivavideos/features/movies/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  const MoviesRepositoryImpl(
      {required this.remoteDataSource, required this.networkInfo});

  final MoviesRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<(Movies?, Failure?)> getMovies() {
    throw UnimplementedError();
  }
}
