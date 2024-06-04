import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/login/login_bloc.dart';
import 'package:tcc/authentication/view/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: BlocProvider(
            create: (context) {
              return LoginBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 24),
              child: Column(
                children: [
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
