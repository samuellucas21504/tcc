// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequestDTO {
  final String email;
  final String password;
  LoginRequestDTO({
    required this.email,
    required this.password,
  });

  LoginRequestDTO copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequestDTO(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory LoginRequestDTO.fromMap(Map<String, dynamic> map) {
    return LoginRequestDTO(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestDTO.fromJson(String source) =>
      LoginRequestDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
