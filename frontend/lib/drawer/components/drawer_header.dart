import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/components/user_avatar.dart';
import 'package:tcc/config/colors.dart';

class UserDrawerHeader extends StatelessWidget {
  const UserDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: UserAvatar(avatarUrl: user.avatarUrl),
        ),
        Text(
          user.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: ThemeColors.onSurface,
          ),
        ),
        Text(
          user.email,
        ),
      ],
    );
  }
}
