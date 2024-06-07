import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/config/colors.dart';
import 'package:tcc/config/themes.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

      return Drawer(
        child: Theme(
          data: Themes.themeWithTransparentDivider(context),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person,
                    color: ThemeColors.highlight,
                    size: 48,
                  ),
                ),
              ),
              Text(
                user.name,
                textAlign: TextAlign.center,
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  print('Teste');
                },
              ),
              ListTile(
                title: const Text('Sair'),
                onTap: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationLogoutRequested());
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
