import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/friends/bloc/friends_cubirt.dart';
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
    BlocProvider.of<FriendsCubit>(context).fetchFriends();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FriendsCubit, FriendsState>(builder: (context, state) {
      if (state is FriendsLoaded) {
        return Column(
          children: state.friends
              .map((friend) => FriendCard(friend: friend))
              .toList(),
        );
      }
      return const Center(child: CircularProgressIndicator());
    });
  }
}
