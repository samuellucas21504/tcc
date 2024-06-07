// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';

class HabitRecordCubit extends Cubit<HabitRecordState> {
  HabitRecordCubit({required HabitRepository repository})
      : _repository = repository,
        super(HabitRecordInitial());

  final HabitRepository _repository;

  Future fetchRecords() async {
    try {
      emit(HabitRecordInitial());
      final today = DateTime.now();

      _repository.fetchRecords(today.month, today.year).then((records) {
        print(records);
        emit(HabitRecordLoaded(records: records, monthShow: today));
      });
    } catch (_) {
      print(_);
    }
  }
}

sealed class HabitRecordState {}

class HabitRecordInitial extends HabitRecordState {}

class HabitRecordLoaded extends HabitRecordState {
  HabitRecordLoaded({
    required this.records,
    required this.monthShow,
  });

  List<HabitRecord> records;
  DateTime monthShow;
}
