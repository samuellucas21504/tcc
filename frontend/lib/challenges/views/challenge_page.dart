import 'package:challenges_repository/challenges_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/challenges/bloc/challenges_bloc.dart';
import 'package:tcc/challenges/views/challenges_list.dart';
import 'package:tcc/components/padded_scrollview.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({
    super.key,
    required this.challenge,
    required this.bloc,
  });

  final Challenge challenge;
  final ChallengesBloc bloc;

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.challenge.name),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const PaddedScrollView(
          child: Center(child: ChallengesList()),
        ),
      ),
    );
  }

  Future<void> _sendChallengeRequest(
      BuildContext context, ChallengesBloc bloc) {
    String email = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enviar pedido de Amizade'),
          content: SizedBox(
            height: 120,
            child: Column(
              children: [
                const Text(
                    'Digite o email do usuário que você quer adicionar:'),
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
                // bloc.add((email));
              },
            ),
          ],
        );
      },
    );
  }
}
