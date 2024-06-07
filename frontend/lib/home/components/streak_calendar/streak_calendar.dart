import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/home/components/streak_calendar/streak_day.dart';
import 'package:tcc/home/components/texts/section_header_text.dart';
import 'package:tcc/home/cubit/habit_cubit.dart';
import 'package:tcc/home/cubit/habit_record_cubit.dart';
import 'package:tcc/utils/extensions/date_time_extensions.dart';
import 'package:tcc/utils/extensions/string_extensions.dart';

class HabitRecordsCalendar extends StatefulWidget {
  const HabitRecordsCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _HabitRecordsCalendarState();
}

class _HabitRecordsCalendarState extends State {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HabitRecordCubit>(context).fetchRecords();
  }

  final DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<HabitRecordCubit, HabitRecordState>(
          builder: (context, state) {
            if (state is HabitRecordLoaded) {
              final user =
                  context.select((AuthenticationBloc bloc) => bloc.state.user);
              final state = context.select(
                  (HabitRecordCubit bloc) => (bloc.state as HabitRecordLoaded));
              final stringMesAtual =
                  '${state.monthShow.getStringMesAtual().capitalize()} de ${state.monthShow.year}';

              return Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 6,
                        child: SectionHeaderText(stringMesAtual),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () =>
                              user.registeredAt!.isSameMonthAs(state.monthShow)
                                  ? null
                                  : print('1'),
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: GridView.count(
                          crossAxisCount: 10,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: _generateDayRow(context),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () => print('1'),
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const SizedBox(
                height: 70,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        )
      ],
    );
  }

  List<Widget> _generateDayRow(BuildContext context) {
    final state = context
        .select((HabitRecordCubit bloc) => (bloc.state as HabitRecordLoaded));
    final records = state.records;
    final daysThisMonth = state.monthShow.getDaysInMonth();

    final List<Widget> days = [];

    for (int i = 0; i < daysThisMonth; i++) {
      days.add(
        StreakDay(
          active: records.any((element) => element.day == i + 1),
        ),
      );
    }

    return days;
  }
}
