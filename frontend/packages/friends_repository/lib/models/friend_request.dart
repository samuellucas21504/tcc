// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:user_repository/user_repository.dart';

class FriendRequest {
  User requester;
  DateTime date;

  FriendRequest({
    required this.requester,
    required this.date,
  });

  FriendRequest copyWith({
    User? requester,
    DateTime? date,
  }) {
    return FriendRequest(
      requester: requester ?? this.requester,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requester': requester.toJson(),
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory FriendRequest.fromMap(Map<String, dynamic> map) {
    return FriendRequest(
      requester: User.fromMap(map['requester'] as Map<String, dynamic>),
      date: DateTime.parse(map['date'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendRequest.fromJson(String source) =>
      FriendRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FriendRequest(requester: $requester, date: $date)';

  @override
  bool operator ==(covariant FriendRequest other) {
    if (identical(this, other)) return true;

    return other.requester == requester && other.date == date;
  }

  @override
  int get hashCode => requester.hashCode ^ date.hashCode;
}
