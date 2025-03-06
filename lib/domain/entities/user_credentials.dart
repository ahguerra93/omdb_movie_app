import 'package:equatable/equatable.dart';

/// Entity representing user credentials.
class UserCredentials extends Equatable {
  final String user;
  final String password;

  const UserCredentials({
    required this.user,
    required this.password,
  });

  @override
  List<Object?> get props => [user, password];
}
