part of 'friends_bloc.dart';

sealed class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

final class FetchFriends extends FriendsEvent {
  const FetchFriends();
}

final class FriendRequestSubmitted extends FriendsEvent {
  final String email;
  const FriendRequestSubmitted(this.email);
}

final class FriendRequestStateChanged extends FriendsEvent {
  final String email;
  final bool accepted;
  const FriendRequestStateChanged(this.email, {this.accepted = false});
}
