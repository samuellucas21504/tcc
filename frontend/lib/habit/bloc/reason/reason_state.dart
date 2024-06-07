part of 'reason_bloc.dart';

final class ReasonState extends Equatable {
  const ReasonState({
    this.status = FormzSubmissionStatus.initial,
    this.reason = const Reason.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Reason reason;
  final bool isValid;

  ReasonState copyWith({
    FormzSubmissionStatus? status,
    Reason? reason,
    bool? isValid,
  }) {
    return ReasonState(
      status: status ?? this.status,
      reason: reason ?? this.reason,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, reason, isValid];
}
