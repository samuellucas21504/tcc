import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends_repository/friends_repository.dart';
import 'package:tcc/drawer/views/drawer.dart';
import 'package:tcc/drawer/components/menu_button.dart';
import 'package:tcc/components/padded_scrollview.dart';
import 'package:tcc/friends/bloc/friends_cubirt.dart';
import 'package:tcc/friends/views/friends_list.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
        settings: const RouteSettings(name: 'friends_page'),
        builder: (_) {
          return const FriendsPage();
        });
  }

  @override
  State<FriendsPage> createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late final FriendsRepository _friendsRepository;

  @override
  void initState() {
    super.initState();
    _friendsRepository = FriendsRepository(
        authenticationRepository:
            RepositoryProvider.of<AuthenticationRepository>(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FriendsCubit(repository: _friendsRepository),
      child: Scaffold(
        appBar: AppBar(
          leading: const MenuButton(),
        ),
        drawer: const CustomDrawer(),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return const PaddedScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FriendsList(),
                ],
              ),
            );
          },
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
