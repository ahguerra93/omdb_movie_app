import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:omdb_movie_app/data/models/authentication_state.dart';
import 'package:omdb_movie_app/domain/entities/user_credentials.dart';
import 'package:omdb_movie_app/domain/usecases/login.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;
  LoginBloc({
    required this.login,
  }) : super(LoginInitial()) {
    on<CallLoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await login(event.credentials);

      result.fold((failure) {
        emit(const LoginError('Login Failed'));
        emit(LoginInitial());
      }, (auth) {
        if (auth == AuthenticationState.authorized) {
          emit(LoginSuccess());
        } else if (auth == AuthenticationState.unauthorized) {
          emit(const LoginError('User not found'));
          emit(LoginInitial());
        } else {
          emit(const LoginError('Login Failed'));
          emit(LoginInitial());
        }
      });
    });
  }
}
