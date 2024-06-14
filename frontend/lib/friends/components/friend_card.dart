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

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 200,
              height: 75,
              padding: const EdgeInsets.only(left: 80),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.name.capitalize(),
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    friend.email,
                    style: TextStyle(
                      color: colorScheme.onSurface.withAlpha(60),
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: UserAvatar(avatarUrl: friend.avatarUrl),
          ),
        ],
      ),
    );
  }
}
