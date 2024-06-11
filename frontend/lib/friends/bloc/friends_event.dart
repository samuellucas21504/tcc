part of 'friends_bloc.dart';

sealed class FriendsEvent extends Equatable {
  const FriendsEvent();

  @override
  List<Object> get props => [];
}

final class FetchFriends extends FriendsEvent {
  const FetchFriends();
}

final class FriendRequestModalOpened extends FriendsEvent {
  const FriendRequestModalOpened();
}

final class FriendRequestModalClosed extends FriendsEvent {
  const FriendRequestModalClosed();
}

final class FriendRequestSubmitted extends FriendsEvent {
  final String email;
  const FriendRequestSubmitted(this.email);
}
