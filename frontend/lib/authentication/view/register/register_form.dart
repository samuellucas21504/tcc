import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tcc/authentication/bloc/register/register_bloc.dart';
import 'package:tcc/authentication/models/email_confirmation.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(
              content: Text('Authentication Failure'),
            ));
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _UsernameInput(),
            const Padding(padding: EdgeInsets.all(10)),
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _EmailConfirmationInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _LoginButton(),
            const Padding(padding: EdgeInsets.all(25)),
            const Divider(),
            const Padding(padding: EdgeInsets.all(25)),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Já é cadastrado?',
                style: TextStyle(
                  color: colorScheme.surface,
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<RegisterBloc>().add(LoginUsernameChanged(username)),
          decoration: InputDecoration(
            labelText: 'Usuário',
            errorText:
                state.username.displayError != null ? 'Usuário inválido' : null,
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textfield'),
          onChanged: (email) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(email)),
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

class _EmailConfirmationInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) =>
          previous.emailConfirmation != current.emailConfirmation,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailConfirmationInput_textfield'),
          onChanged: (emailConfirmation) => context
              .read<RegisterBloc>()
              .add(RegisterEmailConfirmationChanged(emailConfirmation)),
          decoration: InputDecoration(
            labelText: 'Confirmação do Email',
            errorText: state.emailConfirmation.displayError != null
                ? (state.emailConfirmation.displayError
                        as EmailConfirmationValidationError)
                    .name
                : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textfield'),
          onChanged: (password) => context
              .read<RegisterBloc>()
              .add(RegisterPasswordChanged(password)),
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
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                key: const Key('loginForm_continue_raisedButton'),
                onPressed: state.isValid
                    ? () => context
                        .read<RegisterBloc>()
                        .add(const RegisterSubmitted())
                    : null,
                child: state.status.isInProgress
                    ? const CircularProgressIndicator()
                    : const Text('Registre-se'),
              ),
            ),
          ],
        );
      },
    );
  }
}
