import 'package:challenges_repository/challenges_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'challenges_event.dart';
part 'challenges_state.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  ChallengesBloc({required ChallengesRepository repository})
      : _repository = repository,
        super(ChallengesState.unknown()) {
    on<FetchChallenges>(_handleFetchChallenges);
    on<ChallengeCreationRequest>(_handleCreateChallengeRequest);
    on<ChallengeRequestSubmitted>(_handleChallengeRequestSubmitted);
    on<ChallengeRequestStateChanged>(_handleChallengeRequestStateChanged);
  }

  final ChallengesRepository _repository;

  Future _handleFetchChallenges(
      FetchChallenges event, Emitter<ChallengesState> emit) async {
    try {
      emit(ChallengesState.fetching());

      await _repository.getChallenges().then((dto) {
        print('@a ${dto.challenges}');
        emit(ChallengesState.loaded(dto.challenges, dto.requests));
      });
    } catch (_) {
      print("@a $_");
    }
  }

  Future _handleCreateChallengeRequest(
      ChallengeCreationRequest event, Emitter<ChallengesState> emit) async {
    try {
      await _repository.register(event.name, event.finishesAt).then((dto) {
        emit(ChallengesState.created());
      });
    } catch (_) {
      print("@a $_");
    }
  }

  Future _handleChallengeRequestSubmitted(
      ChallengeRequestSubmitted event, Emitter<ChallengesState> emit) async {
    // try {
    //   await _repository.sendFriendRequest(event.email);
    // } catch (_) {
    //   print(_);
    // }
  }

  Future _handleChallengeRequestStateChanged(
      ChallengeRequestStateChanged event, Emitter<ChallengesState> emit) async {
    // try {
    //   await _repository.handleFriendRequest(event.email, event.accepted);
    //   state.requests
    //       .removeWhere((element) => element.requester.email == event.email);
    //   emit(ChallengesState.loaded(state.friends, state.requests));
    //   add(const FetchChallenges());
    // } catch (_) {}
  }
}
