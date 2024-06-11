part of 'friends_bloc.dart';

class FriendsState {
  FriendsState._({required this.status, List<Friend>? friends}) {
    friends == null ? this.friends = [] : this.friends = friends;
  }

  final FriendsStatus status;
  late final List<Friend> friends;

  bool get hasFriends => friends.isNotEmpty;

  FriendsState.unknown() : this._(status: FriendsStatus.unknown);
  FriendsState.fetching() : this._(status: FriendsStatus.fetching);
  FriendsState.loaded(List<Friend> friends)
      : this._(status: FriendsStatus.loaded, friends: friends);
}

enum FriendsStatus {
  unknown,
  fetching,
  loaded,
}
