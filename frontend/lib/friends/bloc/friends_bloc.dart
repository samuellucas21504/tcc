import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_repository/friends_repository.dart';
import 'package:friends_repository/models/friend.dart';
import 'package:equatable/equatable.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc({required FriendsRepository repository})
      : _repository = repository,
        super(FriendsState.unknown()) {
    on<FetchFriends>(_handleFetchFriends);
    on<FriendRequestSubmitted>(_handleFriendRequestSubmitted);
  }

  final FriendsRepository _repository;

  Future _handleFetchFriends(
      FetchFriends state, Emitter<FriendsState> emit) async {
    try {
      emit(FriendsState.fetching());

      await _repository.getFriends().then((friends) {
        emit(FriendsState.loaded(friends));
      });
    } catch (_) {
      print(_);
    }
  }

  Future _handleFriendRequestSubmitted(
      FriendRequestSubmitted event, Emitter<FriendsState> emit) async {
    try {
      await _repository.sendFriendRequest(event.email);
    } catch (_) {
      print(_);
    }
  }
}
