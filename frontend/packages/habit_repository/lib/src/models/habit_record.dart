import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class HabitRecord {
  int day;
  HabitRecord({
    required this.day,
  });

  HabitRecord copyWith({
    int? day,
    int? month,
    int? year,
  }) {
    return HabitRecord(day: day ?? this.day);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'day': day};
  }

  factory HabitRecord.fromMap(Map<String, dynamic> map) {
    return HabitRecord(day: map['day'] as int);
  }

  String toJson() => json.encode(toMap());

  factory HabitRecord.fromJson(String source) =>
      HabitRecord.fromMap(json.decode(source) as Map<String, dynamic>);

  static fromMapList(List<dynamic> map) {
    return map.map((record) => HabitRecord(day: record['day'])).toList();
  }
}
