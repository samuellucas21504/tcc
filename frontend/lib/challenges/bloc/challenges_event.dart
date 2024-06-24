part of 'challenges_bloc.dart';

sealed class ChallengesEvent extends Equatable {
  const ChallengesEvent();

  @override
  List<Object> get props => [];
}

final class FetchChallenges extends ChallengesEvent {
  const FetchChallenges();
}

final class ChallengeCreationRequest extends ChallengesEvent {
  final String name;
  final DateTime finishesAt;
  const ChallengeCreationRequest(this.name, this.finishesAt);
}

final class ChallengeCreated extends ChallengesEvent {}

final class ChallengeRequestSubmitted extends ChallengesEvent {
  final String email;
  const ChallengeRequestSubmitted(this.email);
}

final class ChallengeRequestStateChanged extends ChallengesEvent {
  final String email;
  final bool accepted;
  const ChallengeRequestStateChanged(this.email, {this.accepted = false});
}
