import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:tcc/habit/models/reason.dart';

part 'reason_event.dart';
part 'reason_state.dart';

class ReasonBloc extends Bloc<ReasonEvent, ReasonState> {
  ReasonBloc({
    required habitRepository,
  })  : _habitRepository = habitRepository,
        super(const ReasonState()) {
    on<ReasonChanged>(_onObjectiveChanged);
    on<ReasonSubmitted>(_onObjectiveSubmitted);
  }

  final HabitRepository _habitRepository;

  Future<void> _onObjectiveChanged(
    ReasonChanged event,
    Emitter<ReasonState> emit,
  ) async {
    final reason = Reason.dirty(event.objective);
    emit(state.copyWith(
      reason: reason,
      status: FormzSubmissionStatus.initial,
      isValid: Formz.validate([reason]),
    ));
  }

  Future<void> _onObjectiveSubmitted(
    ReasonSubmitted event,
    Emitter<ReasonState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        await _habitRepository.register(
          objective: state.reason.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
