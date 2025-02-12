import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tcc/components/padded_scrollview.dart';
import 'package:tcc/friends/bloc/friends_bloc.dart';
import 'package:tcc/components/request_card.dart';

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
  Widget build(BuildContext context) {
    final bloc = context.read<FriendsBloc>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        title: const Text('Pedidos de amizade'),
      ),
      body: PaddedScrollView(
        child: SingleChildScrollView(
          child: BlocBuilder<FriendsBloc, FriendsState>(
            builder: (context, state) {
              return bloc.state.requests.isEmpty
                  ? const Center(
                      child: Text('Você não tem nenhum pedido de amizade!'))
                  : Column(
                      children: bloc.state.requests
                          .map((request) => RequestCard(
                                title:
                                    '${request.requester.name} quer ser seu amigo!',
                                subTitle:
                                    "${request.requester.email}\n${DateFormat('kk:mm dd/MM/yy').format(request.date)}",
                                handleAccept: () =>
                                    bloc.add(FriendRequestStateChanged(
                                  request.requester.email,
                                  accepted: true,
                                )),
                                handleRefuse: () => bloc.add(
                                  FriendRequestStateChanged(
                                    request.requester.email,
                                    accepted: false,
                                  ),
                                ),
                              ))
                          .toList(),
                    );
            },
          ),
        ),
      ),
    );
  }
}
