// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Friend {
  final String name;
  final String email;
  final String? avatarUrl;

  Friend({
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      name: map['name'] as String,
      email: map['email'] as String,
      avatarUrl: map['avatar_url'] != null ? map['avatar_url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Friend.fromJson(String source) =>
      Friend.fromMap(json.decode(source) as Map<String, dynamic>);
}
