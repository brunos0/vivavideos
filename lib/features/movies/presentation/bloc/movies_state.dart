import 'package:equatable/equatable.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';

abstract class MoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class Empty extends MoviesState {}

class Loading extends MoviesState {}

class Loaded extends MoviesState {
  Loaded({required this.movies});
  final Movies movies;

  @override
  List<Object?> get props => [movies];
}

class Error extends MoviesState {
  Error({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}
