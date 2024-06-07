import 'package:habit_repository/habit_repository.dart';

sealed class HabitState {}

class HabitDefault extends HabitState {}

class HabitLoaded extends HabitState {
  HabitLoaded(this.habit, this.record);

  final Habit habit;
  final HabitRecord record;

  final DateTime currentMonthShow = DateTime.now();
}

class HabitRenewal extends HabitState {}
