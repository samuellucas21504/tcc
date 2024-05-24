import 'dart:async';
import 'package:user_repository/src/models/models.dart';

class UserRepository {
  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      Duration(milliseconds: 300),
      () => _user = User(
        id: 'a',
        name: 'Samuel',
        email: 'samuellucasrdg@gmail.com',
        avatarUrl: 'aa',
      ),
    );
  }
}
