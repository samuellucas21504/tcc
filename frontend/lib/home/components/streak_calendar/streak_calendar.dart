import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:tcc/home/components/streak_calendar/streak_day.dart';
import 'package:tcc/home/components/texts/section_header_text.dart';
import 'package:tcc/home/cubit/habit_cubit.dart';
import 'package:tcc/home/cubit/habit_state.dart';
import 'package:tcc/utils/extensions/date_time_extensions.dart';
import 'package:tcc/utils/extensions/string_extensions.dart';

class HabitRecordsCalendar extends StatefulWidget {
  const HabitRecordsCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _HabitRecordsCalendarState();
}

class _HabitRecordsCalendarState extends State {
  final DateTime today = DateTime.now();

  List<Widget> _generateDayRow(BuildContext context) {
    final state =
        context.select((HabitCubit bloc) => (bloc.state as HabitLoaded));
    final record = state.record;
    final currentMonthShow = state.currentMonthShow;

    final daysThisMonth = today.getDaysInMonth();

    for (var record in record.records) {
      print(record);
    }
    final List<Widget> days = [];

    for (int i = 0; i < daysThisMonth; i++) {
      days.add(StreakDay(active: Random().nextBool()));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final stringMesAtual = today.getStringMesAtual().capitalize();

    return BlocProvider<HabitCubit>(
      create: (context) {
        return HabitCubit(
            repository: RepositoryProvider.of<HabitRepository>(context));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderText(stringMesAtual),
          GridView.count(
            crossAxisCount: 10,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _generateDayRow(context),
          ),
        ],
      ),
    );
  }
}
