part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class LoginUsernameChanged extends RegisterEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class LoginPasswordChanged extends RegisterEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class LoginSubmitted extends RegisterEvent {
  const LoginSubmitted();
}

final class LoginEmailChanged extends RegisterEvent {
  const LoginEmailChanged(this.email);

  final String email;
  @override
  List<Object> get props => [email];
}

final class LoginEmailConfirmationChanged extends RegisterEvent {
  const LoginEmailConfirmationChanged(this.emailConfirmation);

  final String emailConfirmation;
  @override
  List<Object> get props => [emailConfirmation];
}
