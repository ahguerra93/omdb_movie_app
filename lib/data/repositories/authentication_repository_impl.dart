import 'package:dartz/dartz.dart';
import 'package:omdb_movie_app/data/datasources/authentication_data_source.dart';
import 'package:omdb_movie_app/data/models/authentication_state.dart';
import 'package:omdb_movie_app/domain/entities/user_credentials.dart';
import 'package:omdb_movie_app/domain/repositories/authentication_repository.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';

/// Implementation of the AuthenticationRepository interface.
/// Communicates with the remote data source and maps data to domain entities.
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  /// Checks authentication state of user credentials
  final AuthenticationDataSource authenticationDataSource;

  AuthenticationRepositoryImpl({required this.authenticationDataSource});
  @override
  Future<Either<Failure, AuthenticationState>> login(
      UserCredentials userCredentials) async {
    try {
      final result = await authenticationDataSource.login(userCredentials);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
