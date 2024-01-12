import 'package:flutter_test/flutter_test.dart';
//import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:vivavideos/features/movies/domain/repositories/movies_repository.dart';

@GenerateNiceMocks([
  MockSpec<MoviesRepository>(),
])
//import 'movies_repository_impl_test.mocks.dart';

void main() {
  testWidgets('movies.repository ...', (tester) async {});
}
