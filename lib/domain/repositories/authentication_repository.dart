import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/core/error/failures.dart';
import 'package:omdb_movie_app/data/models/authentication_state.dart';
import 'package:omdb_movie_app/domain/entities/user_credentials.dart';

abstract class AuthenticationRepository {
  /// Searches for login credentials
  Future<Either<Failure, AuthenticationState>> login(
    UserCredentials userCredentials,
  );
}
