import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/core/usecases/usecase.dart';
import 'package:omdb_movie_app/data/models/authentication_state.dart';
import 'package:omdb_movie_app/domain/entities/user_credentials.dart';
import 'package:omdb_movie_app/domain/repositories/authentication_repository.dart';

/// Use case to fetch login information about given login credentials.
class Login implements UseCase<AuthenticationState, UserCredentials> {
  final AuthenticationRepository repository;

  Login(this.repository);

  /// Executes the use case by delegating to the repository.
  @override
  Future<Either<Failure, AuthenticationState>> call(
      UserCredentials userCredentials) async {
    return await repository.login(userCredentials);
  }
}
