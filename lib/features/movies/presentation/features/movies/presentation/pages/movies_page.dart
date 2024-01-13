import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivavideos/features/movies/presentation/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:vivavideos/features/movies/presentation/features/movies/presentation/bloc/movies_event.dart';
import 'package:vivavideos/features/movies/presentation/features/movies/presentation/bloc/movies_state.dart';
import 'package:vivavideos/injection_container.dart';

import '../widgets/widgets.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  'assets/popcorn.png',
                  width: 80,
                  height: 80,
                ),
                const Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Viva Videos!',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Seu Catálogo atualizado \n das novidades dos cinemas!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ]),
            ),
            SingleChildScrollView(child: buildBody(context)),
          ],
        ),
      ),
    );
  }

  BlocProvider<MoviesBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoviesBloc>(),
      // Top half
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                builder: (context, state) {
                  if (state is Empty) {
                    BlocProvider.of<MoviesBloc>(context).add(GetMoviesEvent());
                    return const MessageDisplay(
                        message: 'Retrieving new movies list!');
                  } else if (state is Loading) {
                    return const LoadingWidget();
                  } else if (state is Loaded) {
                    return MoviesDisplay(
                      movies: state.movies,
                    );
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
