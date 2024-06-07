import 'package:flutter/material.dart';

class StreakDay extends StatelessWidget {
  final bool active;

  const StreakDay({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: active
            ? const Color.fromARGB(255, 214, 207, 237)
            : colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
    );
  }
}
