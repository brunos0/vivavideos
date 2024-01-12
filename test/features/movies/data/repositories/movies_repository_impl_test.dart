import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/core/platform/network_info.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:vivavideos/features/movies/data/models/movies_model.dart';
import 'package:vivavideos/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
//import 'package:vivavideos/features/movies/domain/entities/movies.dart';

@GenerateNiceMocks([
  MockSpec<MoviesRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
])
import 'movies_repository_impl_test.mocks.dart';

void main() {
  late MoviesRepositoryImpl repository;
  late MockMoviesRemoteDataSource mockMoviesRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  const mockResult = (
    MoviesModel(movies: [
      MovieItem(
          originalTitle: 'titanic',
          overview: 'E afundou',
          urlCover: 'teste.jpeg'),
    ]),
    null
  );
  final mockNoInternet = (null, NoInternetException());

  setUp(() {
    mockMoviesRemoteDataSource = MockMoviesRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MoviesRepositoryImpl(
      remoteDataSource: mockMoviesRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getMovies', () {
/*
  test('should get movies for the repository', () async {
    // arrange
    //when()
    // act

    // assert
  });

  });
  
  */
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockMoviesRemoteDataSource.getMovies())
          .thenAnswer((_) async => mockResult);

      // act
      repository.getMovies();

      //assert
      verify(mockNetworkInfo.isConnected);
    });
  });

  group('getMovies', () {
    setUp(
        () => when(mockNetworkInfo.isConnected).thenAnswer((_) async => true));
    test('should get movies for the repository', () async {
      // arrange

      when(mockMoviesRemoteDataSource.getMovies())
          .thenAnswer((_) async => mockResult);
      // act
      final result = await repository.getMovies();
      // assert
      expect(result, mockResult);
    });

    test('should get movies for the repository', () async {
      // arrange

      when(mockMoviesRemoteDataSource.getMovies())
          .thenAnswer((_) async => mockResult);
      // act
      final result = await repository.getMovies();
      // assert
      expect(result, mockResult);
    });
  });

  group('getMovies', () {
    setUp(
        () => when(mockNetworkInfo.isConnected).thenAnswer((_) async => false));
    test('should throw a NoInternetException when device is offline', () async {
      // arrange

      when(mockMoviesRemoteDataSource.getMovies())
          .thenAnswer((_) async => mockResult);
      // act
      final result = await repository.getMovies();
      // assert
      expect(result, mockNoInternet);
    });
  });
}
