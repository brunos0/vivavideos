import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:vivavideos/core/platform/network_info.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:vivavideos/features/movies/data/repositories/movies_repository_impl.dart';
//import 'package:vivavideos/features/movies/domain/repositories/movies_repository.dart';

@GenerateNiceMocks([
  MockSpec<MoviesRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'movies_repository_impl_test.mocks.dart';

void main() {
  MoviesRepositoryImpl repository;
  MockMoviesRemoteDataSource mockMoviesRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockMoviesRemoteDataSource = MockMoviesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MoviesRepositoryImpl(
      remoteDataSource: mockMoviesRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  testWidgets('movies repository impl ...', (tester) async {});
}
