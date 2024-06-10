import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  static const iconRadius = 45.0;

  const UserAvatar({
    super.key,
    required this.avatarUrl,
  });

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return avatarUrl != null
        ? CircleAvatar(
            radius: iconRadius,
            backgroundImage: NetworkImage(avatarUrl!),
          )
        : Container(
            width: iconRadius * 2,
            height: iconRadius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.onSurface,
            ),
            child: Icon(
              Icons.person,
              color: colorScheme.background,
              size: 48,
            ),
          );
  }
}
