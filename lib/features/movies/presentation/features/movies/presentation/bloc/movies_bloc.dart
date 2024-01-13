import 'package:bloc/bloc.dart';
/*
import 'package:dartz/dartz.dart';
import 'package:resocoder/core/error/failures.dart';
import 'package:resocoder/core/usecases/usecase.dart';
import 'package:resocoder/core/util/input_converter.dart';
import 'package:resocoder/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:resocoder/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:resocoder/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:resocoder/features/number_trivia/presentation/bloc/number_trivia_event.dart';
import 'package:resocoder/features/number_trivia/presentation/bloc/number_trivia_state.dart';
*/
import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/core/usecases/usecase.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';
import 'package:vivavideos/features/movies/presentation/features/movies/presentation/bloc/movies_event.dart';
import 'package:vivavideos/features/movies/presentation/features/movies/presentation/bloc/movies_state.dart';
import 'package:vivavideos/features/movies/domain/usecases/get_movies.dart';

const String serverFailureMessage = 'Server Failure';
const String noInternetFailureMessage = 'No Internet Failure';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc({
    required this.getMovies,
  }) : super(Empty()) {
    on<MoviesEvent>((MoviesEvent event, Emitter<MoviesState> emit) async {
      if (event is GetMoviesEvent) {
        emit(Loading());
        final (movies, failure) = await getMovies(NoParams());

        _eitherLoadedOrErrorState(movies, failure, emit);
      }
    });
  }

  void _eitherLoadedOrErrorState(
    Movies? movies,
    Failure? failure,
    Emitter<MoviesState> emit,
  ) {
    //failureOrTrivia.fold((failure) {
    if (failure != null) {
      emit(Error(message: _mapFailureToMessage(failure)));
    } else {
      emit(Loaded(movies: movies!));
    }
  }

  final GetMovies getMovies;

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case NoInternetException:
        return noInternetFailureMessage;
      default:
        return 'unexpected error';
    }
  }
}
