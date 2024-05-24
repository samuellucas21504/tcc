import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tcc/home/components/streak_calendar/streak_day.dart';
import 'package:tcc/home/components/texts/section_header_text.dart';
import 'package:tcc/utils/extensions/date_time_extensions.dart';
import 'package:tcc/utils/extensions/string_extensions.dart';

class StreakCalendar extends StatefulWidget {
  const StreakCalendar({super.key});

  @override
  State<StatefulWidget> createState() => _StreakCalendarState();
}

class _StreakCalendarState extends State {
  final DateTime today = DateTime.now();

  List<Widget> _generateDayRow(int quantityOfDays) {
    final List<Widget> days = [];

    for (int i = 0; i < quantityOfDays; i++) {
      days.add(StreakDay(active: Random().nextBool()));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final daysThisMonth = today.getDaysInMonth();
    final stringMesAtual = today.getStringMesAtual().capitalize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderText(stringMesAtual),
        GridView.count(
          crossAxisCount: 10,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: _generateDayRow(daysThisMonth),
        ),
      ],
    );
  }
}
