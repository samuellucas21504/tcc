import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ChallengeRecord {
  int day;
  ChallengeRecord({
    required this.day,
  });

  ChallengeRecord copyWith({
    int? day,
    int? month,
    int? year,
  }) {
    return ChallengeRecord(day: day ?? this.day);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'day': day};
  }

  factory ChallengeRecord.fromMap(Map<String, dynamic> map) {
    return ChallengeRecord(day: map['day'] as int);
  }

  String toJson() => json.encode(toMap());

  factory ChallengeRecord.fromJson(String source) =>
      ChallengeRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  static fromMapList(List<dynamic> map) {
    return map.map((record) => ChallengeRecord(day: record['day'])).toList();
  }
}
