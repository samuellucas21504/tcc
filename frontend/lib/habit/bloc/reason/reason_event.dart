part of 'reason_bloc.dart';

sealed class ReasonEvent extends Equatable {
  const ReasonEvent();
}

final class ReasonChanged extends ReasonEvent {
  final String objective;

  const ReasonChanged(this.objective);

  @override
  List<Object> get props => [objective];
}

final class ReasonSubmitted extends ReasonEvent {
  const ReasonSubmitted();

  @override
  List<Object> get props => [];
}
