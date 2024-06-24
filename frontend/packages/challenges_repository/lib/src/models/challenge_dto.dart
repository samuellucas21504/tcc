// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:challenges_repository/challenges_repository.dart';

class ChallengeDTO {
  List<Challenge> challenges;
  List<ChallengeRequest> requests;
  ChallengeDTO({
    required this.challenges,
    required this.requests,
  });
}
