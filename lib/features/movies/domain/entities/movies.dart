import 'package:equatable/equatable.dart';
import 'package:vivavideos/features/movies/domain/entities/movie_item.dart';

class Movies extends Equatable {
  const Movies({required this.movies});
  final List<MovieItem> movies;

  @override
  List<Object?> get props => [movies];
}
