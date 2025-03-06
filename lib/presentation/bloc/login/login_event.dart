part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class CallLoginEvent extends LoginEvent {
  final UserCredentials credentials;

  const CallLoginEvent({required this.credentials});

  @override
  List<Object> get props => [credentials];
}
