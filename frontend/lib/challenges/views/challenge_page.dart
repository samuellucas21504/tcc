import 'package:challenges_repository/challenges_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/challenges/bloc/challenges_bloc.dart';
import 'package:tcc/challenges/components/challenge_record_card.dart';
import 'package:tcc/components/padded_scrollview.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({
    super.key,
    required this.id,
    required this.bloc,
  });

  final String id;
  final ChallengesBloc bloc;

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<ChallengesBloc, ChallengesState>(
        bloc: widget.bloc,
        builder: (context, state) {
          final user =
              context.select((AuthenticationBloc bloc) => bloc.state.user);
          final challenge =
              state.challenges.firstWhere((element) => element.id == widget.id);

          for (ChallengeRecord record in challenge.records ?? []) {
            print(record.user.email);
          }

          final topRecord = List.of(challenge.records!).reduce(
              (current, next) => current.streak > next.streak ? current : next);
          final userRecord = challenge.records!
              .firstWhere((element) => element.user.email == user.email);
          final canRecord = userRecord.lastUpdated == null ||
              userRecord.lastUpdated!.difference(DateTime.now()).inDays <= -1;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Desafio'),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                TextButton(
                  onPressed: () => _sendChallengeRequest(
                    context,
                    widget.bloc,
                    challenge.id!,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text('Convidar'),
                  ),
                )
              ],
            ),
            body: PaddedScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          challenge.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        ChallengeRecordCard(
                          title: "Maior recorde",
                          record: topRecord,
                        ),
                        SizedBox(width: width * 0.1),
                        ChallengeRecordCard(
                          title: "Seu recorde",
                          record: userRecord,
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    if (canRecord)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => widget.bloc.add(
                                  RecordChallengeSubmitted(
                                      challenge.id!, user)),
                              child: const Text(
                                'Registrar',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<void> _sendChallengeRequest(
      BuildContext context, ChallengesBloc bloc, String challengeId) {
    String email = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enviar convite de desafio'),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                const Text('Digite o email do usuário que você quer convidar:'),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) => email = value,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Enviar'),
              onPressed: () {
                Navigator.pop(context);
                bloc.add(ChallengeRequestSubmitted(email, challengeId));
              },
            ),
          ],
        );
      },
    );
  }
}
