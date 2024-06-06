import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_freezed.freezed.dart';
part 'user_freezed.g.dart';

@Freezed()
class User with _$User {
  const factory User({
    required String name,
    String? email,
    bool? habitRegistered,
    String? token,
  }) = _User;

  factory User.fromJson(String source) =>
      _$UserFromJson(json.decode(source) as Map<String, dynamic>);

  static const empty = User(name: '-');
  static const key = 'user_key';
}
