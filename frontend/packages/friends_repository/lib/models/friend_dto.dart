// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:friends_repository/models/friend.dart';
import 'package:friends_repository/models/friend_request.dart';

class FriendDTO {
  List<Friend> friends;
  List<FriendRequest> requests;
  FriendDTO({
    required this.friends,
    required this.requests,
  });

  FriendDTO copyWith({
    List<Friend>? friends,
    List<FriendRequest>? requests,
  }) {
    return FriendDTO(
      friends: friends ?? this.friends,
      requests: requests ?? this.requests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'friends': friends.map((x) => x.toMap()).toList(),
      'requests': requests.map((x) => x.toMap()).toList(),
    };
  }

  factory FriendDTO.fromMap(Map<String, dynamic> map) {
    return FriendDTO(
      friends: List<Friend>.from(
        (map['friends'] as List<dynamic>).map<Friend>(
          (x) => Friend.fromMap(x as Map<String, dynamic>),
        ),
      ),
      requests: List<FriendRequest>.from(
        (map['requests'] as List<dynamic>).map<FriendRequest>(
          (x) => FriendRequest.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendDTO.fromJson(String source) =>
      FriendDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
