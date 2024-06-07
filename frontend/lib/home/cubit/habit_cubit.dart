import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit({required HabitRepository repository})
      : _repository = repository,
        super(HabitInitial());

  final HabitRepository _repository;

  Future fetchHabit() async {
    try {
      emit(HabitInitial());
      print('a');
      _repository.getHabit().then((habit) {
        print(habit);
        if (habit != null) {
          emit(HabitLoaded(habit));
        }
      });
    } catch (_) {
      print(_);
    }
  }
}

sealed class HabitState {}

class HabitInitial extends HabitState {}

class HabitLoaded extends HabitState {
  HabitLoaded(this.habit);

  final Habit habit;

  final DateTime currentMonthShow = DateTime.now();
}

class HabitRenewal extends HabitState {}
