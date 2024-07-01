part of 'challenges_bloc.dart';

class ChallengesState {
  const ChallengesState._({
    required this.status,
    required this.challenges,
    required this.requests,
  });

  final ChallengesStatus status;
  final List<Challenge> challenges;
  final List<ChallengeRequest> requests;

  bool get hasChallenges => challenges.isNotEmpty;

  const ChallengesState.unknown()
      : this._(
          status: ChallengesStatus.unknown,
          challenges: const [],
          requests: const [],
        );
  const ChallengesState.fetching()
      : this._(
          status: ChallengesStatus.fetching,
          challenges: const [],
          requests: const [],
        );
  const ChallengesState.loaded(
    List<Challenge> challenges,
    List<ChallengeRequest> requests,
  ) : this._(
          status: ChallengesStatus.loaded,
          challenges: challenges,
          requests: requests,
        );
  const ChallengesState.created()
      : this._(
          status: ChallengesStatus.newChallenge,
          challenges: const [],
          requests: const [],
        );
}

enum ChallengesStatus { unknown, fetching, loaded, newChallenge }
