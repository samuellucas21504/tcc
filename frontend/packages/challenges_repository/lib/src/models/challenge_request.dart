// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:challenges_repository/challenges_repository.dart';
import 'package:user_repository/user_repository.dart';

class ChallengeRequest {
  User requester;
  Challenge challenge;
  DateTime date;

  ChallengeRequest({
    required this.requester,
    required this.challenge,
    required this.date,
  });

  ChallengeRequest copyWith({
    User? requester,
    Challenge? challenge,
    DateTime? date,
  }) {
    return ChallengeRequest(
      requester: requester ?? this.requester,
      challenge: challenge ?? this.challenge,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requester': requester.toJson(),
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory ChallengeRequest.fromMap(Map<String, dynamic> map) {
    return ChallengeRequest(
      requester: User.fromMap(map['requester'] as Map<String, dynamic>),
      challenge: Challenge.fromMap(map['challenge']),
      date: DateTime.parse(map['date'] as String),
    );
  }

  static List<ChallengeRequest> fromMapList(List<dynamic> sourceList) {
    return sourceList
        .map((source) => ChallengeRequest.fromMap(source))
        .toList();
  }

  String toJson() => json.encode(toMap());

  factory ChallengeRequest.fromJson(String source) =>
      ChallengeRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChallengeRequest(requester: $requester, date: $date)';

  @override
  bool operator ==(covariant ChallengeRequest other) {
    if (identical(this, other)) return true;

    return other.requester == requester && other.date == date;
  }

  @override
  int get hashCode => requester.hashCode ^ date.hashCode;
}
