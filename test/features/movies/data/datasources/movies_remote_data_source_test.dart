import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
//import 'package:vivavideos/core/error/failures.dart';
//import 'package:vivavideos/core/platform/network_info.dart';
import 'package:vivavideos/core/util/fixture.dart';
//import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source_impl.dart';
import 'package:vivavideos/features/movies/data/models/movies_model.dart';
//import 'package:vivavideos/features/movies/data/repositories/movies_repository_impl.dart';
//import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
//import 'package:vivavideos/features/movies/domain/entities/movies.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@GenerateNiceMocks([MockSpec<http.Client>()])
import 'movies_remote_data_source_test.mocks.dart';

void main() {
  late MoviesRemoteDataSourceImpl dataSource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    dataSource = MoviesRemoteDataSourceImpl(client: mockClient);
  });

  group('getMovies', () {
    final tMoviesModel =
        MoviesModel.fromJson(json.decode(fixture('movies.json')));
    test('should perform a Get request on a URL with bear token in json format',
        () async {
      // arrange
      when(mockClient.get(any,
              headers: {'Content-Type': 'application/json; charset=utf-8'}))
          .thenAnswer((_) async => http.Response(
                fixture('movies.json'),
                200,
              ));

      // act
      dataSource.getMovies();
      // assert

      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
      //));
    });

    test('should return movies when the response code is 200 (success)',
        () async {
      // arrange
      when(mockClient.get(any,
              headers: {'Content-Type': 'application/json; charset=utf-8'}))
          .thenAnswer((_) async => http.Response(
                fixture('movies.json'),
                200,
              ));

      // act
      final (result, failure) = await dataSource.getMovies();
      // assert
      expect(failure, null);
      expect(result, tMoviesModel);
      //));
    });
  });
}
