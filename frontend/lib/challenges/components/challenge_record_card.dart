import 'package:challenges_repository/challenges_repository.dart';
import 'package:flutter/material.dart';

class ChallengeRecordCard extends StatelessWidget {
  final ChallengeRecord record;
  final String title;

  const ChallengeRecordCard({
    super.key,
    required this.record,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.35,
      height: width * 0.35,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 10),
            child: _CardText(title),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "${record.streak}",
              style: TextStyle(
                color: colorScheme.background,
                fontWeight: FontWeight.w800,
                fontSize: width * 0.14,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 10),
            child: _CardText(record.user.name),
          ),
        ],
      ),
    );
  }
}

class _CardText extends StatelessWidget {
  final String text;

  const _CardText(this.text);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      text,
      style: TextStyle(
        fontSize: width * 0.043,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
    );
  }
}
