import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/config/colors.dart';

class UserDrawerHeader extends StatelessWidget {
  const UserDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    final userHasAvatar = user.avatarUrl != null;
    const iconRadius = 45.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: userHasAvatar
              ? const CircleAvatar(
                  radius: iconRadius,
                  backgroundImage: null,
                )
              : Container(
                  width: iconRadius * 2,
                  height: iconRadius * 2,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ThemeColors.highlight,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: ThemeColors.background,
                    size: 48,
                  ),
                ),
        ),
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: ThemeColors.highlight,
          ),
        ),
        Text(
          user.email,
        ),
      ],
    );
  }
}
