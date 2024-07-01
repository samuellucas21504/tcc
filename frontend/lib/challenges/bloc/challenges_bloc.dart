import 'package:challenges_repository/challenges_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'challenges_event.dart';
part 'challenges_state.dart';

class ChallengesBloc extends Bloc<ChallengesEvent, ChallengesState> {
  ChallengesBloc({required ChallengesRepository repository})
      : _repository = repository,
        super(const ChallengesState.unknown()) {
    on<FetchChallenges>(_handleFetchChallenges);
    on<ChallengeCreationRequest>(_handleCreateChallengeRequest);
    on<ChallengeRequestSubmitted>(_handleChallengeRequestSubmitted);
    on<ChallengeRequestStateChanged>(_handleChallengeRequestStateChanged);
    on<RecordChallengeSubmitted>(_handleRecordChallengeSubmitted);
  }

  final ChallengesRepository _repository;

  Future _handleFetchChallenges(
      FetchChallenges event, Emitter<ChallengesState> emit) async {
    try {
      emit(const ChallengesState.fetching());

      await _repository.getChallenges().then((dto) {
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
        emit(const ChallengesState.created());
      });
    } catch (_) {
      print("@a $_");
    }
  }

  Future _handleRecordChallengeSubmitted(
      RecordChallengeSubmitted event, Emitter<ChallengesState> emit) async {
    try {
      await _repository.record(event.challengeId);

      List<Challenge> challenges = List.from(state.challenges);

      int index =
          challenges.indexWhere((element) => element.id == event.challengeId);
      if (index == -1) return;

      List<ChallengeRecord> records = List.from(challenges[index].records!);

      int recordIndex = records
          .indexWhere((element) => element.user.email == event.user.email);
      if (recordIndex == -1) return;

      ChallengeRecord newRecord = records[recordIndex].copyWith(
        streak: records[recordIndex].streak + 1,
        lastUpdated: DateTime.now(),
      );
      records[recordIndex] = newRecord;
      challenges[index] = challenges[index].copyWith(records: records);

      emit(ChallengesState.loaded(challenges, state.requests));
    } catch (_) {
      print("@a $_");
    }
  }

  Future _handleChallengeRequestSubmitted(
      ChallengeRequestSubmitted event, Emitter<ChallengesState> emit) async {
    try {
      await _repository.sendChallengeInvitation(event.email, event.challengeId);
    } catch (_) {
      print(_);
    }
  }

  Future _handleChallengeRequestStateChanged(
      ChallengeRequestStateChanged event, Emitter<ChallengesState> emit) async {
    try {
      await _repository.handleChallengeRequest(
        event.email,
        event.accepted,
        event.challengeId,
      );
      List<ChallengeRequest> updatedRequests = List.from(state.requests);
      updatedRequests.removeWhere((element) =>
          element.requester.email == event.email &&
          element.challenge.id! == event.challengeId);

      emit(ChallengesState.loaded(state.challenges, updatedRequests));
      add(const FetchChallenges());
    } catch (_) {
      print(_);
    }
  }
}
