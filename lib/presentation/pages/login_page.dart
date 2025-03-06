import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omdb_movie_app/domain/entities/user_credentials.dart';
import 'package:omdb_movie_app/presentation/bloc/login/login_bloc.dart';
import 'package:omdb_movie_app/presentation/pages/search_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController userController;
  late final TextEditingController passwordController;

  @override
  initState() {
    userController = TextEditingController(text: 'user123');
    passwordController = TextEditingController(text: 'test123');
    super.initState();
  }

  String? validator(value) =>
      value?.isEmpty ?? true ? 'This field is mandatory' : null;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchPage(),
                  ),
                );
              } else if (state is LoginError) {
                final snackBar = SnackBar(content: Text(state.message));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'WELCOME!',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 30),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please enter you username (user123/test123)',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: state is! LoginLoading,
                      controller: userController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Username',
                          style: textStyle,
                        ),
                      ),
                      validator: validator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      enabled: state is! LoginLoading,
                      obscureText: true,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        label: Text(
                          'Password',
                          style: textStyle,
                        ),
                      ),
                      validator: validator,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.maxFinite,
                      child: OutlinedButton(
                        onPressed: () {
                          if (state is LoginLoading) return;
                          if (_formKey.currentState?.validate() ?? false) {
                            context.read<LoginBloc>().add(
                                  CallLoginEvent(
                                    credentials: UserCredentials(
                                      user: userController.text,
                                      password: passwordController.text,
                                    ),
                                  ),
                                );
                          }
                        },
                        child: Text(
                          state is LoginLoading ? 'Loading...' : 'Log in',
                          style: textStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
