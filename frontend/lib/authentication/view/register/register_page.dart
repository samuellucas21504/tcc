import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/register/register_bloc.dart';
import 'package:tcc/authentication/view/login/login_page.dart';
import 'package:tcc/authentication/view/register/register_form.dart';
import 'package:tcc/home/components/rectangular_round_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute(builder: (_) => const RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: BlocProvider(
              create: (context) {
                return RegisterBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository>(context),
                );
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 24),
                child: Column(
                  children: [
                    const RegisterForm(),
                    const Divider(),
                    const Padding(padding: EdgeInsets.all(15)),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Já é cadastrado?',
                      ),
                    ),
                    Row(children: [
                      Expanded(
                        child: RectangularRoundButton(
                          onPressed: () =>
                              Navigator.push(context, LoginPage.route()),
                          child: const Text('Login'),
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
