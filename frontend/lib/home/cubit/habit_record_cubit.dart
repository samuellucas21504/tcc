// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';

class HabitRecordCubit extends Cubit<HabitRecordState> {
  HabitRecordCubit({required HabitRepository repository})
      : _repository = repository,
        super(HabitRecordInitial());

  final HabitRepository _repository;

  Future _fetchRecords(int month, int year, {bool firstFetch = false}) async {
    try {
      _repository.fetchRecords(month, year).then((records) {
        bool todayIsRecorded;
        if (firstFetch) {
          todayIsRecorded =
              records.isNotEmpty && records.last.day == DateTime.now().day;
        } else {
          todayIsRecorded = (state as HabitRecordLoaded).isTodayRecorded;
        }

        emit(HabitRecordLoaded(
          records: records,
          monthShow: DateTime(year, month),
          isTodayRecorded: todayIsRecorded,
        ));
      });
    } catch (_) {
      print(_);
    }
  }

  Future fetchRecordsOfPreviousMonth() async {
    final monthShow = (state as HabitRecordLoaded).monthShow;
    int month = mod(monthShow.month - 1, 13);
    int year = monthShow.year;
    _fetchRecords(month, year);
  }

  Future fetchRecordsOfThisMonth() async {
    emit(HabitRecordInitial());

    final today = DateTime.now();
    _fetchRecords(today.month, today.year, firstFetch: true);
  }

  Future fetchRecordsOfNextMonth() async {
    print('entrou');
    final monthShow = (state as HabitRecordLoaded).monthShow;
    int month = mod(monthShow.month + 1, 13);
    int year = monthShow.year;

    if (month == 0) {
      year += 1;
      month = 1;
    }
    _fetchRecords(month, year);
  }

  int mod(int number, int max) {
    return ((number % max) + max) % max;
  }

  Future record() async {
    try {
      _repository.record();

      final currentState = (state as HabitRecordLoaded);

      emit(
        HabitRecordLoaded(
          records: [
            ...currentState.records,
            HabitRecord(day: DateTime.now().day)
          ],
          monthShow: currentState.monthShow,
          isTodayRecorded: true,
        ),
      );
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
    required this.isTodayRecorded,
  });

  final List<HabitRecord> records;
  final DateTime monthShow;
  final bool isTodayRecorded;
}
