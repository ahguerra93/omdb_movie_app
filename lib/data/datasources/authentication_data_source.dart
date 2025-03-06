import 'package:omdb_movie_app/data/models/authentication_state.dart';
import 'package:omdb_movie_app/domain/entities/user_credentials.dart';

/// Interface for fetching Authentication data.
abstract class AuthenticationDataSource {
  Future<AuthenticationState> login(UserCredentials userCredentials);
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  /// Fetches existing hardcoded credentials.
  @override
  Future<AuthenticationState> login(UserCredentials userCredentials) async {
    late AuthenticationState authenticationState;
    await Future.delayed(const Duration(seconds: 1));
    if (userCredentials.user == 'user123' &&
        userCredentials.password == 'test123') {
      authenticationState = AuthenticationState.authorized;
    } else {
      authenticationState = AuthenticationState.unauthorized;
    }
    return authenticationState;
  }
}
