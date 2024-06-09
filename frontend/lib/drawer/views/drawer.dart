import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tcc/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:tcc/config/themes.dart';
import 'package:tcc/drawer/components/drawer_header.dart';
import 'package:tcc/friends/views/friends_page.dart';
import 'package:tcc/home/view/home_page.dart';

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
                    leading: const Icon(Icons.home_outlined),
                    title: const Text('Home'),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      Navigator.pop(context);
                      bool isAlreadyOnHome =
                          !(ModalRoute.of(context)?.settings.name ==
                              HomePage.route().settings.name);
                      if (isAlreadyOnHome) {
                        Navigator.pushAndRemoveUntil(
                            context, HomePage.route(), (route) => false);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Amigos'),
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      Navigator.pop(context);
                      if (!(ModalRoute.of(context)?.settings.name ==
                          FriendsPage.route().settings.name)) {
                        Navigator.pushAndRemoveUntil(
                            context, FriendsPage.route(), (route) => false);
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.arrow_back),
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
