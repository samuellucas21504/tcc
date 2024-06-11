import 'package:flutter/material.dart';
import 'package:friends_repository/models/models.dart';
import 'package:intl/intl.dart';
import 'package:tcc/friends/bloc/friends_bloc.dart';

class FriendRequestCard extends StatelessWidget {
  const FriendRequestCard({
    super.key,
    required this.friendRequest,
    required this.bloc,
  });

  final FriendRequest friendRequest;
  final FriendsBloc bloc;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.surface),
        color: colorScheme.surface,
      ),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${friendRequest.requester.name} quer ser seu amigo!',
                softWrap: true,
                maxLines: 2,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                "${friendRequest.requester.email}\n${DateFormat('kk:mm dd/MM/yy').format(friendRequest.date)}",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface.withAlpha(80),
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
              onPressed: () => bloc.add(FriendRequestStateChanged(
                    friendRequest.requester.email,
                    accepted: true,
                  )),
              icon: const Icon(Icons.check)),
          IconButton(
              onPressed: () => bloc.add(FriendRequestStateChanged(
                    friendRequest.requester.email,
                    accepted: false,
                  )),
              icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
