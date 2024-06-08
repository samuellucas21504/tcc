import 'package:flutter/material.dart';
import 'package:tcc/drawer/views/drawer.dart';
import 'package:tcc/drawer/components/menu_button.dart';
import 'package:tcc/components/padded_scrollview.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const MenuButton(),
      ),
      drawer: const CustomDrawer(),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return const PaddedScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[],
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
