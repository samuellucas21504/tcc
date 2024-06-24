import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_repository/friends_repository.dart';
import 'package:equatable/equatable.dart';

part 'friends_event.dart';
part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  FriendsBloc({required FriendsRepository repository})
      : _repository = repository,
        super(FriendsState.unknown()) {
    on<FetchFriends>(_handleFetchFriends);
    on<FriendRequestSubmitted>(_handleFriendRequestSubmitted);
    on<FriendRequestStateChanged>(_handleFriendRequestStateChanged);
  }

  final FriendsRepository _repository;

  Future _handleFetchFriends(
      FetchFriends state, Emitter<FriendsState> emit) async {
    try {
      emit(FriendsState.fetching());

      await _repository.getFriends().then((dto) {
        emit(FriendsState.loaded(dto.friends, dto.requests));
      });
    } catch (_) {
      print("@a $_");
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

  Future _handleFriendRequestStateChanged(
      FriendRequestStateChanged event, Emitter<FriendsState> emit) async {
    try {
      await _repository.handleFriendRequest(event.email, event.accepted);
      state.requests
          .removeWhere((element) => element.requester.email == event.email);
      emit(FriendsState.loaded(state.friends, state.requests));
      add(const FetchFriends());
    } catch (_) {}
  }
}
