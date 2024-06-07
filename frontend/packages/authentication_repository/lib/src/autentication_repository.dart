import 'dart:async';

import 'package:authentication_repository/src/config/constants.dart';
import 'package:authentication_repository/src/models/login/login_request_dto.dart';
import 'package:authentication_repository/src/models/register/request_register_dto.dart';
import 'package:dio/dio.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus {
  unknown,
  unauthenticated,
  authenticated,
}

class AuthenticationRepository {
  static const String tokenKey = 'token_key';

  final _controller = StreamController<AuthenticationStatus>();
  final _userRepository = UserRepository();
  final _storageRepository = StorageRepository();
  final _dio = Dio();

  String? token;

  Stream<AuthenticationStatus> get status async* {
    final user = await _userRepository.getUser();

    if (user == null) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      yield AuthenticationStatus.authenticated;
    }

    yield* _controller.stream;
  }

  Future<String> getToken() async {
    if (token == null) {
      token = await _storageRepository.read(tokenKey);
      if (token == null) _controller.add(AuthenticationStatus.unauthenticated);
    }

    return token!;
  }

  Future<String> getBearerToken() async {
    String token = await getToken();
    return 'Bearer ${token}';
  }

  void _saveToken(String token) {
    _storageRepository.write(tokenKey, token);
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final body =
        RequestRegisterDTO(name: name, email: email, password: password);

    Response response =
        await _dio.post('${Constants.url}/auth/register', data: body.toJson());

    final data = response.data;
    final headers = response.headers;

    final dto = User(
      name: data['name'],
      email: data['email'],
      habitRegistered: data['habit_registered'],
    );
    _saveToken(headers['token']!.first);

    await _userRepository.changeUser(dto);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final body = LoginRequestDTO(email: email, password: password);

    Response response =
        await _dio.post('${Constants.url}/auth/login', data: body.toJson());

    final data = response.data;
    final headers = response.headers;

    final dto = User(
      name: data['name'],
      email: data['email'],
      habitRegistered: data['habit_registered'],
    );
    _saveToken(headers['token']!.first);

    await _userRepository.changeUser(dto);

    _controller.add(AuthenticationStatus.authenticated);
  }

  void userAddedHabit() {
    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    _userRepository.logout();
  }

  void dispose() => _controller.close();
}
