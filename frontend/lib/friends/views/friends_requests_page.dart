import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_repository/models/models.dart';
import 'package:tcc/components/padded_scrollview.dart';
import 'package:tcc/friends/bloc/friends_bloc.dart';
import 'package:tcc/friends/components/friend_request_card.dart';
import 'package:user_repository/user_repository.dart';

class FriendsRequestPage extends StatefulWidget {
  const FriendsRequestPage({super.key});

  static Route route(BuildContext context) {
    return MaterialPageRoute(builder: (_) {
      return BlocProvider.value(
        value: BlocProvider.of<FriendsBloc>(context),
        child: const FriendsRequestPage(),
      );
    });
  }

  @override
  State<FriendsRequestPage> createState() => _FriendsRequestPageState();
}

class _FriendsRequestPageState extends State<FriendsRequestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FriendsBloc>();
    print(bloc.state.requests);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: const Text('Pedidos de amizade'),
      ),
      body: PaddedScrollView(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...bloc.state.requests
                  .map((request) =>
                      FriendRequestCard(friendRequest: request, bloc: bloc))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
