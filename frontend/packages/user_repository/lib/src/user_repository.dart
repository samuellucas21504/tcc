import 'dart:async';
import 'dart:convert';
import 'package:storage_repository/storage_repository.dart';
import 'package:user_repository/src/models/models.dart';

class UserRepository {
  User? _user;
  final _storageRepository = StorageRepository();

  Future<User?> getUser() async {
    if (_user != null) return _user;
    final user = await _storageRepository.read(User.key);

    if (user == null || user.isEmpty) return null;

    return User.fromJson(user);
  }

  Future<void> changeUser(User user) async {
    await _storageRepository.write(User.key, jsonEncode(user.toJson()));
    _user = user;
    print(user);
  }

  Future logout() async {
    await _storageRepository.delete(User.key);
  }
}
