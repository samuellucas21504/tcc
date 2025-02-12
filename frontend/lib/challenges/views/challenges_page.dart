import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/challenges/bloc/challenges_bloc.dart';
import 'package:tcc/challenges/views/challenges_list.dart';
import 'package:tcc/challenges/views/challenges_requests_page.dart';
import 'package:tcc/challenges/views/create_challenge_view.dart';
import 'package:tcc/drawer/views/drawer.dart';
import 'package:tcc/drawer/components/menu_button.dart';
import 'package:tcc/components/padded_scrollview.dart';
import 'package:tcc/friends/components/notification_bell.dart';

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
                Navigator.push(context, CreateChallengeView.route()).then(
              (value) {
                context.read<ChallengesBloc>().add(const FetchChallenges());
              },
            ),
            icon: const Icon(Icons.add),
          ),
          BlocBuilder<ChallengesBloc, ChallengesState>(
            builder: (context, state) {
              if (state.status == ChallengesStatus.loaded) {
                return IconButton(
                    onPressed: () {
                      Navigator.push(
                          context, ChallengesRequestsPage.route(context));
                    },
                    icon: NotificationBell(
                      notificationQuantity:
                          context.read<ChallengesBloc>().state.requests.length,
                    ));
              } else {
                return const NotificationBell(notificationQuantity: 0);
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
}
