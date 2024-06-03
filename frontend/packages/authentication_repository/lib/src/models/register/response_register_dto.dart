// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';

class ResponseRegisterDTO {
  final String name;
  final String email;
  final String token;

  ResponseRegisterDTO({
    required this.name,
    required this.email,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory ResponseRegisterDTO.fromMap(Map<String, dynamic> map) {
    return ResponseRegisterDTO(
      name: map['name'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseRegisterDTO.fromJson(String source) =>
      ResponseRegisterDTO.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ResponseRegisterDTO.fromResponse(Response response) {
    print(response.data);
    if (response.data == null) throw Exception('Response data is null');

    return ResponseRegisterDTO.fromMap(response.data);
  }
}
