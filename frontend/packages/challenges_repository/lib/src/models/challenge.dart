import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:user_repository/user_repository.dart';

part 'challenge.freezed.dart';
part 'challenge.g.dart';

@Freezed()
class Challenge with _$Challenge {
  const factory Challenge({
    required String name,
    User? creator,
    List<User>? participants,
  }) = _Challenge;

  factory Challenge.fromMap(Map<String, dynamic> source) => Challenge(
        name: source['name'],
        creator: User.fromMap(source['creator']),
        participants: User.fromMapList(source['participants']),
      );

  factory Challenge.fromJson(String source) =>
      _$ChallengeFromJson(json.decode(source) as Map<String, dynamic>);

  static List<Challenge> fromMapList(List<dynamic> sourceList) {
    return sourceList.map((source) => Challenge.fromMap(source)).toList();
  }

  static const empty = Challenge(name: '-');
  static const key = 'challenge_key';
}
