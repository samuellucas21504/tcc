import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tcc/challenges/bloc/challenges_bloc.dart';
import 'package:tcc/components/padded_scrollview.dart';
import 'package:tcc/components/request_card.dart';

class ChallengesRequestsPage extends StatefulWidget {
  const ChallengesRequestsPage({super.key});

  static Route route(BuildContext context) {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider.value(
        value: BlocProvider.of<ChallengesBloc>(context),
        child: const ChallengesRequestsPage(),
      );
    });
  }

  @override
  State<ChallengesRequestsPage> createState() => _ChallengesRequestsPage();
}

class _ChallengesRequestsPage extends State<ChallengesRequestsPage> {
  final DateFormat format = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChallengesBloc>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: const Text('Pedidos de desafios'),
      ),
      body: PaddedScrollView(
        child: SingleChildScrollView(
          child: BlocBuilder<ChallengesBloc, ChallengesState>(
            builder: (context, state) {
              if (state.status == ChallengesStatus.loaded) {
                return bloc.state.requests.isEmpty
                    ? const Center(
                        child: Text('Você não tem nenhum pedido de desafio!'))
                    : Column(
                        children: bloc.state.requests
                            .map((request) => RequestCard(
                                  title:
                                      '${request.requester.name} te desafiou para ${request.challenge.name} até ${format.format(request.challenge.finishesAt!)}!',
                                  subTitle:
                                      "${request.requester.email}\n${DateFormat('kk:mm dd/MM/yy').format(request.date)}",
                                  handleAccept: () => bloc.add(
                                    ChallengeRequestStateChanged(
                                      request.requester.email,
                                      accepted: true,
                                      challengeId: request.challenge.id!,
                                    ),
                                  ),
                                  handleRefuse: () => bloc.add(
                                    ChallengeRequestStateChanged(
                                      request.requester.email,
                                      accepted: false,
                                      challengeId: request.challenge.id!,
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
