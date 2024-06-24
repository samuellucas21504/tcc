part of 'challenges_bloc.dart';

class ChallengesState {
  ChallengesState._(
      {required this.status,
      List<Challenge>? challenges,
      List<ChallengeRequest>? requests}) {
    challenges == null ? challenges = [] : this.challenges = challenges;
    requests == null ? requests = [] : this.requests = requests;
  }

  final ChallengesStatus status;
  late final List<Challenge> challenges;
  late final List<ChallengeRequest> requests;

  bool get hasChallenges => challenges.isNotEmpty;

  ChallengesState.unknown() : this._(status: ChallengesStatus.unknown);
  ChallengesState.fetching() : this._(status: ChallengesStatus.fetching);
  ChallengesState.loaded(
      List<Challenge> challenges, List<ChallengeRequest> requests)
      : this._(
          status: ChallengesStatus.loaded,
          challenges: challenges,
          requests: requests,
        );
}

enum ChallengesStatus {
  unknown,
  fetching,
  loaded,
}
