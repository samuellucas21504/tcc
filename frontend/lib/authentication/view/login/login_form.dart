import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tcc/authentication/bloc/login/login_bloc.dart';
import 'package:tcc/authentication/bloc/register/register_bloc.dart';
import 'package:tcc/home/components/rectangular_round_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('Aconteceu algum erro de autenticação'),
            ));
        }
      },
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          _EmailInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _PasswordInput(),
          const Padding(padding: EdgeInsets.all(12)),
          _LoginButton(),
          const Padding(padding: EdgeInsets.all(15)),
        ]),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textfield'),
          onChanged: (email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'Email',
            errorText:
                state.email.displayError != null ? 'Email inválido' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textfield'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Senha',
            errorText:
                state.password.displayError != null ? 'Senha inválida' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
                child: RectangularRoundButton(
              key: key,
              onPressed: () =>
                  context.read<LoginBloc>().add(const LoginSubmitted()),
              isInProgess: state.status.isInProgress,
              isValid: state.isValid,
              child: const Text('Login'),
            )),
          ],
        );
      },
    );
  }
}
