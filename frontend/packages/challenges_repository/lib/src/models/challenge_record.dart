import 'dart:convert';

import 'package:user_repository/user_repository.dart';

class ChallengeRecord {
  final int streak;
  final DateTime? lastUpdated;
  final User user;

  const ChallengeRecord({
    required this.streak,
    required this.user,
    this.lastUpdated,
  });

  ChallengeRecord copyWith({
    int? streak,
    User? user,
    DateTime? lastUpdated,
  }) {
    return ChallengeRecord(
      streak: streak ?? this.streak,
      user: user ?? this.user,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'streak': streak,
      'user': user.toJson(),
      'last_updated': lastUpdated?.millisecondsSinceEpoch
    };
  }

  factory ChallengeRecord.fromMap(Map<String, dynamic> map) {
    return ChallengeRecord(
        streak: map['streak'] as int,
        user: User.fromMap(map['user'] as Map<String, dynamic>),
        lastUpdated: map['last_updated'] != null
            ? DateTime.parse(map['last_updated'])
            : null);
  }

  static List<ChallengeRecord> fromMapList(List<dynamic> sourceList) {
    return sourceList.map((source) => ChallengeRecord.fromMap(source)).toList();
  }

  String toJson() => json.encode(toMap());

  factory ChallengeRecord.fromJson(String source) =>
      ChallengeRecord.fromMap(json.decode(source) as Map<String, dynamic>);
}
