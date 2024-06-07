import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:tcc/home/cubit/habit_state.dart';

class HabitCubit extends Cubit<HabitState> {
  HabitCubit({required HabitRepository repository})
      : _repository = repository,
        super(HabitDefault());

  final HabitRepository _repository;

  Future fetchHabit() async {
    try {
      emit(HabitDefault());
      print('a');
      _repository.getHabit().then((habit) {
        print(habit);
        if (habit != null) {
          emit(HabitLoaded(habit, HabitRecord(records: [])));
        }
      });
    } catch (_) {
      print(_);
    }
  }
}
