import 'package:equatable/equatable.dart';

class MovieItem extends Equatable {
  const MovieItem({
    required this.originalTitle,
    required this.overview,
    required this.urlCover,
  });

  final String originalTitle;
  final String overview;
  final String urlCover;

  @override
  List<Object?> get props => [originalTitle, overview, urlCover];
}
