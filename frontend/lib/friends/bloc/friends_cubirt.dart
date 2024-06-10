import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_repository/friends_repository.dart';
import 'package:friends_repository/models/friend.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit({required FriendsRepository repository})
      : _repository = repository,
        super(FriendsInitial());

  final FriendsRepository _repository;

  Future fetchFriends() async {
    try {
      emit(FriendsInitial());
      _repository.getFriends().then((friends) {
        if (friends.isNotEmpty) {
          emit(FriendsLoaded(friends));
        }
      });
    } catch (_) {
      print(_);
    }
  }
}

sealed class FriendsState {}

class FriendsInitial extends FriendsState {}

class FriendsLoaded extends FriendsState {
  FriendsLoaded(this.friends);

  final List<Friend> friends;
}

class FriendRenewal extends FriendsState {}
