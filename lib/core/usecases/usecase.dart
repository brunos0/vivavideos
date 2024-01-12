import 'package:equatable/equatable.dart';
import 'package:vivavideos/core/error/failures.dart';
import 'package:vivavideos/features/movies/domain/entities/movies.dart';

abstract class UseCase<Type, Params> {
  Future<(Movies?, Failure?)> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
