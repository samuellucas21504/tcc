import 'package:flutter/material.dart';
import 'package:tcc/config/colors.dart';

class HabitRecordDay extends StatelessWidget {
  final bool active;

  const HabitRecordDay({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: active ? ThemeColors.highlight : colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
    );
  }
}
