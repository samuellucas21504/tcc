import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:tcc/authentication/models/email.dart';
import 'package:tcc/authentication/models/email_confirmation.dart';
import 'package:tcc/authentication/models/password.dart';
import 'package:tcc/authentication/models/username.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const RegisterState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginEmailConfirmationChanged>(_onEmailConfirmationChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
        username: username,
        status: ifFailureChangeStatus(),
        isValid: Formz.validate([
          state.password,
          state.email,
          state.emailConfirmation,
          username,
        ])));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(state.copyWith(
        password: password,
        status: ifFailureChangeStatus(),
        isValid: Formz.validate([
          state.username,
          state.email,
          state.emailConfirmation,
          password,
        ])));
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    final emailConfirmation = EmailConfirmation.dirty(
        email: email.value, value: state.emailConfirmation.value);

    emit(state.copyWith(
        email: email,
        emailConfirmation: emailConfirmation,
        status: ifFailureChangeStatus(),
        isValid: Formz.validate([
          state.username,
          state.password,
          email,
          emailConfirmation,
        ])));
  }

  void _onEmailConfirmationChanged(
    LoginEmailConfirmationChanged event,
    Emitter<RegisterState> emit,
  ) {
    final emailConfirmation = EmailConfirmation.dirty(
        email: state.email.value, value: event.emailConfirmation);

    emit(state.copyWith(
        emailConfirmation: emailConfirmation,
        status: ifFailureChangeStatus(),
        isValid: Formz.validate([
          state.username,
          state.password,
          state.email,
          emailConfirmation,
        ])));
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        await _authenticationRepository.register(
          name: state.username.value,
          email: state.email.value,
          password: state.password.value,
        );

        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        print(_);
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  FormzSubmissionStatus ifFailureChangeStatus() {
    if (state.status.isFailure) {
      return FormzSubmissionStatus.initial;
    }

    return state.status;
  }
}
