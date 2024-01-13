// ignore_for_file: unused_local_variable

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:vivavideos/core/error/exceptions.dart';
import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/core/platform/network_info.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:vivavideos/features/movies/data/models/movies_model.dart';
import 'package:vivavideos/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';

@GenerateNiceMocks([
  MockSpec<MoviesRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'movies_repository_impl_test.mocks.dart';

void main() {
  late MoviesRepositoryImpl repository;
  late MockMoviesRemoteDataSource mockMoviesRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const mockDataSourceResult = MoviesModel(movies: [
    MovieItem(
        originalTitle: 'titanic',
        overview: 'E afundou',
        urlCover: 'navioAfundando.jpeg'),
  ]);
  const mockRepositoryResult = (
    mockDataSourceResult,
    null,
  );

  final mockNoInternet = (null, NoInternetException());

  void dataSourceGetMovies() => when(mockMoviesRemoteDataSource.getMovies())
      .thenAnswer((_) async => mockDataSourceResult);

  void deviceOnline() =>
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

  void deviceOffline() =>
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

  setUp(() {
    mockMoviesRemoteDataSource = MockMoviesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MoviesRepositoryImpl(
      remoteDataSource: mockMoviesRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getMovies', () {
    test('should check if the device is online', () async {
      // arrange
      deviceOnline();
      dataSourceGetMovies();

      // act
      repository.getMovies();

      //assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should get movies for the repository', () async {
      // arrange
      deviceOnline();
      dataSourceGetMovies();
      // act
      final (success, failure) = await repository.getMovies();
      // assert
      expect(success, mockRepositoryResult);
    });

    test(
        'should throw a ServerFailure when device is online but Api not response',
        () async {
      // arrange
      deviceOnline();
      when(mockMoviesRemoteDataSource.getMovies()).thenThrow(ServerException());
      // act
      final (success, failure) = await repository.getMovies();
      // assert
      expect(failure, ServerFailure());
    });
  });

  group('getMovies', () {
    test('should throw a NoInternetException when device is offline', () async {
      // arrange
      deviceOffline();
      dataSourceGetMovies();
      // act
      final (success, failure) = await repository.getMovies();
      // assert
      expect(success, mockNoInternet);
    });
  });
}
