import 'package:equatable/equatable.dart';

abstract class MoviesEvent extends Equatable {
  const MoviesEvent(List<Object?> props);
}

class GetMoviesEvent extends MoviesEvent {
  GetMoviesEvent() : super([]);

  @override
  List<Object?> get props => [];
}
