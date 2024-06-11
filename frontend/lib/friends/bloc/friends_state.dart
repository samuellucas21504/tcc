part of 'friends_bloc.dart';

class FriendsState {
  FriendsState._({
    required this.status,
    List<Friend>? friends,
    List<FriendRequest>? requests,
  }) {
    friends == null ? this.friends = [] : this.friends = friends;
    requests == null ? this.requests = [] : this.requests = requests;
  }

  final FriendsStatus status;
  late final List<Friend> friends;
  late final List<FriendRequest> requests;

  bool get hasFriends => friends.isNotEmpty;

  FriendsState.unknown() : this._(status: FriendsStatus.unknown);
  FriendsState.fetching() : this._(status: FriendsStatus.fetching);
  FriendsState.loaded(List<Friend> friends, List<FriendRequest> requests)
      : this._(
            status: FriendsStatus.loaded, friends: friends, requests: requests);
}

enum FriendsStatus {
  unknown,
  fetching,
  loaded,
}
