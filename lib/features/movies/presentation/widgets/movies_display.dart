import 'package:flutter/material.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';
import 'package:vivavideos/features/movies/presentation/widgets/movie_clip.dart';

class MoviesDisplay extends StatelessWidget {
  const MoviesDisplay({
    required this.movies,
    super.key,
  });

  final Movies movies;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: [
        SizedBox(
          width: 400,
          height: 600,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.movies.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                  width: 300,
                  height: 600,
                  child: MovieClip(
                      movieName: movies.movies[index].originalTitle,
                      movieDescription: movies.movies[index].overview,
                      moviePoster: movies.movies[index].urlCover));
            },
          ),
        ),
      ]),
    );
  }
}
