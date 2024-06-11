import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/friends/bloc/friends_bloc.dart';
import 'package:tcc/friends/components/friend_card.dart';

class FriendsList extends StatefulWidget {
  const FriendsList({super.key});

  @override
  State<FriendsList> createState() => _FriendListState();
}

class _FriendListState extends State<FriendsList> {
  @override
  void initState() {
    super.initState();
    context.read<FriendsBloc>().add(const FetchFriends());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsBloc, FriendsState>(
      builder: (context, state) {
        if (state.status == FriendsStatus.loaded) {
          if (state.hasFriends) {
            return Column(
              children: state.friends
                  .map((friend) => FriendCard(friend: friend))
                  .toList(),
            );
          }

          final colorScheme = Theme.of(context).colorScheme;

          return Column(
            children: [
              const Icon(Icons.person_off_rounded, size: 84),
              Text(
                'Você ainda não tem nenhum amigo adicionado!',
                style: TextStyle(color: colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
