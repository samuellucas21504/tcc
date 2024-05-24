import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:tcc/login/models/email.dart';
import 'package:tcc/login/models/email_confirmation.dart';
import 'package:tcc/login/models/password.dart';
import 'package:tcc/login/models/username.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginEmailConfirmationChanged>(_onEmailConfirmationChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
        username: username,
        isValid: Formz.validate([
          state.password,
          state.email,
          state.emailConfirmation,
          username,
        ])));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.username,
          state.email,
          state.emailConfirmation,
          password,
        ])));
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email.dirty(event.email);
    final emailConfirmation = EmailConfirmation.dirty(
        email: email.value, value: state.emailConfirmation.value);

    emit(state.copyWith(
        email: email,
        emailConfirmation: emailConfirmation,
        isValid: Formz.validate([
          state.username,
          state.password,
          email,
          emailConfirmation,
        ])));
  }

  void _onEmailConfirmationChanged(
    LoginEmailConfirmationChanged event,
    Emitter<LoginState> emit,
  ) {
    final emailConfirmation = EmailConfirmation.dirty(
        email: state.email.value, value: event.emailConfirmation);

    emit(state.copyWith(
        emailConfirmation: emailConfirmation,
        isValid: Formz.validate([
          state.username,
          state.password,
          state.email,
          state.emailConfirmation,
        ])));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.register(
          username: state.username.value,
          email: state.email.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
