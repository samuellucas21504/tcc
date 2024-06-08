import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit({required HabitRepository repository})
      : _repository = repository,
        super(HabitInitial());

  final HabitRepository _repository;

  Future fetchHabit() async {
    print('fetch');
    try {
      emit(HabitInitial());
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
}

class HabitRenewal extends HabitState {}
