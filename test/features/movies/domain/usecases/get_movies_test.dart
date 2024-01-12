import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:vivavideos/core/error/error.dart';
import 'package:vivavideos/core/usecases/usecase.dart';
import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';
import 'package:vivavideos/features/movies/domain/repositories/movies.repository.dart';
import 'package:vivavideos/features/movies/domain/usecases/get_movies.dart';

@GenerateNiceMocks([
  MockSpec<MoviesRepository>(),
])
import 'get_movies_test.mocks.dart';

void main() {
  late GetMovies usecase;
  late MockMoviesRepository mockMoviesRepository;

  setUpAll(() {
    mockMoviesRepository = MockMoviesRepository();
    usecase = GetMovies(mockMoviesRepository);
  });

  test('should get movies from the repository', () async {
    final mockResult = (
      const Movies(
        movies: [
          MovieItem(
              originalTitle: 'titanic',
              overview: 'E afundou',
              urlCover: 'teste.jpeg'),
        ],
      ),
      ServerFailure()
    );
    // arrange
    when(mockMoviesRepository.getMovies()).thenAnswer((_) async => mockResult);
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, mockResult);
    verify(mockMoviesRepository.getMovies());
    verifyNoMoreInteractions(mockMoviesRepository);
  });
}
