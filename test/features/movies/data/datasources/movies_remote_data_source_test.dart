import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vivavideos/core/error/exceptions.dart';
import 'package:vivavideos/core/util/fixture.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source_impl.dart';
import 'package:vivavideos/features/movies/data/models/movies_model.dart';

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
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
                fixture('movies.json'),
                200,
              ));

      // act
      dataSource.getMovies();
      // assert

      verify(mockClient.get(any, headers: anyNamed('headers'))).called(1);
    });

    test('should return movies when the response code is 200 (success)',
        () async {
      // arrange

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
                fixture('movies.json'),
                200,
              ));

      // act
      final result = await dataSource.getMovies();
      // assert

      expect(result, tMoviesModel);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange

      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(
                'Something really goes bad',
                404,
              ));

      // act
      final call = dataSource.getMovies;
      // assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
