import 'package:challenges_repository/challenges_repository.dart';

class ChallengeDTO {
  List<Challenge> challenges;
  List<ChallengeRequest> requests;
  ChallengeDTO({
    required this.challenges,
    required this.requests,
  });
}
