import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/challenges/bloc/challenges_bloc.dart';

class ChallengesList extends StatefulWidget {
  const ChallengesList({super.key});

  @override
  State<ChallengesList> createState() => _FriendListState();
}

class _FriendListState extends State<ChallengesList> {
  @override
  void initState() {
    super.initState();
    context.read<ChallengesBloc>().add(const FetchChallenges());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengesBloc, ChallengesState>(
      builder: (context, state) {
        if (state.status == ChallengesStatus.loaded) {
          if (state.hasChallenges) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: state.challenges
                  .map((challenge) => Text(challenge.name))
                  .toList(),
            );
          }

          final colorScheme = Theme.of(context).colorScheme;

          return Text(
            'Você ainda não tem nenhum desafio!',
            style: TextStyle(color: colorScheme.onSurface),
            textAlign: TextAlign.center,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
