import 'package:challenges_repository/challenges_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcc/challenges/bloc/challenges_bloc.dart';
import 'package:tcc/challenges/views/challenge_page.dart';

import 'package:tcc/utils/extensions/string_extensions.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({super.key, required this.challenge, required this.bloc});

  final Challenge challenge;
  final ChallengesBloc bloc;

  void navigateToChallengePage(context) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
          settings: const RouteSettings(name: 'challenges_page'),
          builder: (_) {
            return ChallengePage(
              id: challenge.id!,
              bloc: bloc,
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final DateFormat format = DateFormat('dd/MM/yyyy');

    return GestureDetector(
      onTap: () => navigateToChallengePage(context),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Align(
          alignment: Alignment.center,
          child: Container(
            width: 450,
            height: 125,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardRow(
                    firstText: 'Desafio: ',
                    secondText: challenge.name.capitalize()),
                _CardRow(
                    firstText: 'Criado por: ',
                    secondText: challenge.creator!.name.capitalize()),
                _CardRow(
                    firstText: 'Até: ',
                    secondText: format.format(challenge.finishesAt!)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CardRow extends StatelessWidget {
  final String firstText;
  final String secondText;

  const _CardRow({
    required this.firstText,
    required this.secondText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          firstText,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface.withOpacity(0.5),
            fontSize: 14,
          ),
        ),
        Text(
          secondText,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
