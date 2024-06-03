part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.emailConfirmation = const EmailConfirmation.pure(email: ''),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final Email email;
  final EmailConfirmation emailConfirmation;
  final bool isValid;

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Password? password,
    Email? email,
    EmailConfirmation? emailConfirmation,
    bool? isValid,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      emailConfirmation: emailConfirmation ?? this.emailConfirmation,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [status, username, password, email, emailConfirmation];
}
