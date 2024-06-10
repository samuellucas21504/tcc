import 'package:flutter/material.dart';
import 'package:friends_repository/models/friend.dart';
import 'package:tcc/components/user_avatar.dart';
import 'package:tcc/utils/extensions/string_extensions.dart';

class FriendCard extends StatelessWidget {
  const FriendCard({super.key, required this.friend});

  final Friend friend;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          UserAvatar(avatarUrl: friend.avatarUrl),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                friend.name.capitalize(),
                style: TextStyle(color: colorScheme.onSurface),
              ),
              Text(
                friend.email,
                style: TextStyle(
                  color: colorScheme.onSurface.withAlpha(60),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
