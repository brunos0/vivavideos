import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/core/usecases/usecase.dart';
import 'package:vivavideos/features/movies/data/models/movies_model.dart';
import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';
import 'package:vivavideos/features/movies/domain/usecases/get_movies.dart';
import 'package:vivavideos/features/movies/presentation/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:vivavideos/features/movies/presentation/features/movies/presentation/bloc/movies_event.dart';
import 'package:vivavideos/features/movies/presentation/features/movies/presentation/bloc/movies_state.dart';

@GenerateNiceMocks([
  MockSpec<GetMovies>(),
])
import 'movies_bloc_test.mocks.dart';

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

void main() {
  late MoviesBloc bloc;
  late MockGetMovies mockGetMovies;

  setUp(() {
    mockGetMovies = MockGetMovies();
    bloc = MoviesBloc(getMovies: mockGetMovies);
  });

  test('initialState should be Empty', () {
    expect(bloc.state, Empty());
  });

  group('GetTriviaForRandomNumber', () {
    //const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test('should get data from the use case', () async {
      // arrange

      when(mockGetMovies(any)).thenAnswer((_) async => mockRepositoryResult);
      // act
      bloc.add(GetMoviesEvent());
      await untilCalled(mockGetMovies(any));
      // assert
      verify(mockGetMovies(NoParams()));
    });

    blocTest<MoviesBloc, MoviesState>(
      'should emit [Loading, Loaded] when data is gotten successfully',
      build: () {
        when(mockGetMovies(any)).thenAnswer((_) async => mockRepositoryResult);

        return MoviesBloc(getMovies: mockGetMovies);
      },
      act: (bloc) => bloc.add(GetMoviesEvent()),
      expect: () => <MoviesState>[
        Loading(),
        Loaded(movies: mockDataSourceResult),
      ],
    );

    blocTest<MoviesBloc, MoviesState>(
      'should emit [Loading, Error] when getting data fails',
      build: () {
        when(mockGetMovies(any))
            .thenAnswer((_) async => (null, ServerFailure()));

        return MoviesBloc(getMovies: mockGetMovies);
      },
      act: (bloc) => bloc.add(GetMoviesEvent()),
      expect: () => <MoviesState>[
        Loading(),
        Error(message: serverFailureMessage),
      ],
    );

    blocTest<MoviesBloc, MoviesState>(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      build: () {
        when(mockGetMovies(any))
            .thenAnswer((_) async => (null, NoInternetException()));

        return MoviesBloc(getMovies: mockGetMovies);
      },
      act: (bloc) => bloc.add(GetMoviesEvent()),
      expect: () => <MoviesState>[
        Loading(),
        Error(message: noInternetFailureMessage),
      ],
    );
  });
}
