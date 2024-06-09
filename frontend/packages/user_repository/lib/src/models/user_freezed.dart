import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_freezed.freezed.dart';
part 'user_freezed.g.dart';

@Freezed()
class User with _$User {
  const factory User({
    required String name,
    required String email,
    required bool habitRegistered,
    DateTime? registeredAt,
    String? avatarUrl,
  }) = _User;

  factory User.fromMap(Map<String, dynamic> source) => User(
        email: source['email'],
        name: source['name'],
        habitRegistered: source['habit_registered'],
        avatarUrl: source['avatar_url'],
        registeredAt: DateTime.parse(source['registered_at']),
      );

  factory User.fromJson(String source) =>
      _$UserFromJson(json.decode(source) as Map<String, dynamic>);

  static const empty = User(
    name: '-',
    email: '-',
    habitRegistered: false,
  );
  static const key = 'user_key';
}
