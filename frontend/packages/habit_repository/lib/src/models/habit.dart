import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

@Freezed()
class Habit with _$Habit {
  const factory Habit({
    required String reason,
    String? motivation,
  }) = _Habit;

  factory Habit.fromJson(String source) =>
      _$HabitFromJson(json.decode(source) as Map<String, dynamic>);

  static const empty = Habit(reason: '-');
  static const key = 'habit_key';
}
