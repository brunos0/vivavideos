import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:vivavideos/core/platform/network_info.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source.dart';
import 'package:vivavideos/features/movies/data/datasources/movies_remote_data_source_impl.dart';
import 'package:vivavideos/features/movies/data/repositories/movies_repository_impl.dart';
import 'package:vivavideos/features/movies/domain/repositories/movies_repository.dart';
import 'package:vivavideos/features/movies/domain/usecases/get_movies.dart';
import 'package:vivavideos/features/movies/presentation/bloc/movies_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Number Trivia
// Bloc
  sl.registerFactory(() => MoviesBloc(
        getMovies: sl(),
      ));

// Use Cases
  sl.registerLazySingleton(() => GetMovies(sl()));

// Repository
  sl.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl(
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

// Data Sources
  sl.registerLazySingleton<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImpl(client: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}
