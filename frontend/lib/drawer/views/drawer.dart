import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/config/themes.dart';
import 'package:tcc/drawer/components/drawer_header.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Drawer(
        child: Theme(
          data: Themes.themeWithTransparentDivider(context),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const UserDrawerHeader(),
                  ListTile(
                    title: const Text('Home'),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      // Navigator.pop();
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
          ),
        ),
      );
    });
  }
}
