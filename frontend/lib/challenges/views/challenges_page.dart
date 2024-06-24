import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/challenges/bloc/challenges_bloc.dart';
import 'package:tcc/challenges/views/challenges_list.dart';
import 'package:tcc/challenges/views/create_challenge_view.dart';
import 'package:tcc/drawer/views/drawer.dart';
import 'package:tcc/drawer/components/menu_button.dart';
import 'package:tcc/components/padded_scrollview.dart';
import 'package:tcc/friends/components/notification_bell.dart';
import 'package:tcc/friends/views/friends_list.dart';

class ChallengesPage extends StatefulWidget {
  const ChallengesPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        settings: const RouteSettings(name: 'challenges_page'),
        builder: (_) {
          return BlocProvider<ChallengesBloc>(
            create: (context) =>
                ChallengesBloc(repository: RepositoryProvider.of(context)),
            child: const ChallengesPage(),
          );
        });
  }

  @override
  State<ChallengesPage> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends State<ChallengesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuButton(),
        title: const Text('Desafios'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.push(context, CreateChallengeView.route()),
            icon: const Icon(Icons.add),
          ),
          BlocBuilder<ChallengesBloc, ChallengesState>(
            builder: (context, state) {
              if (state.status == ChallengesStatus.loaded) {
                return IconButton(
                    onPressed: () {
                      // TODO - Adicionar
                      // Navigator.push(context, FriendsRequestPage.route(context));
                    },
                    icon: NotificationBell(
                      notificationQuantity:
                          context.read<ChallengesBloc>().state.requests.length,
                    ));
              } else {
                return const NotificationBell(
                  notificationQuantity: 0,
                );
              }
            },
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: const PaddedScrollView(
        child: Center(child: ChallengesList()),
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
