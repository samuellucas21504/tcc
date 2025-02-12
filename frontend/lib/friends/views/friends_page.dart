import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/drawer/views/drawer.dart';
import 'package:tcc/drawer/components/menu_button.dart';
import 'package:tcc/components/padded_scrollview.dart';
import 'package:tcc/friends/bloc/friends_bloc.dart';
import 'package:tcc/friends/components/notification_bell.dart';
import 'package:tcc/friends/views/friends_list.dart';
import 'package:tcc/friends/views/friends_requests_page.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        settings: const RouteSettings(name: 'friends_page'),
        builder: (_) {
          return BlocProvider<FriendsBloc>(
            create: (context) =>
                FriendsBloc(repository: RepositoryProvider.of(context)),
            child: const FriendsPage(),
          );
        });
  }

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuButton(),
        title: const Text('Amigos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                _sendFriendRequest(context, context.read<FriendsBloc>()),
            icon: const Icon(Icons.person_add),
          ),
          BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    Navigator.push(context, FriendsRequestPage.route(context));
                  },
                  icon: NotificationBell(
                    notificationQuantity:
                        context.read<FriendsBloc>().state.requests.length,
                  ));
            },
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: const PaddedScrollView(
              child: FriendsList(),
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _sendFriendRequest(BuildContext context, FriendsBloc bloc) {
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
                bloc.add(FriendRequestSubmitted(email));
              },
            ),
          ],
        );
      },
    );
  }
}
