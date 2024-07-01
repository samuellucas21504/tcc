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
  final String challengeId;

  const ChallengeRequestSubmitted(this.email, this.challengeId);
}

final class ChallengeRequestStateChanged extends ChallengesEvent {
  final String email;
  final bool accepted;
  final String challengeId;

  const ChallengeRequestStateChanged(
    this.email, {
    required this.challengeId,
    this.accepted = false,
  });
}

final class RecordChallengeSubmitted extends ChallengesEvent {
  final String challengeId;
  final User user;

  const RecordChallengeSubmitted(this.challengeId, this.user);
}
