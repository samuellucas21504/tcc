import 'dart:async';

import 'package:authentication_repository/src/config/constants.dart';
import 'package:authentication_repository/src/models/login/login_request_dto.dart';
import 'package:authentication_repository/src/models/register/request_register_dto.dart';
import 'package:dio/dio.dart';
import 'package:user_repository/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _userRepository = UserRepository();
  final _dio = Dio();

  Stream<AuthenticationStatus> get status async* {
    final user = await _userRepository.getUser();

    if (user != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }

    yield* _controller.stream;
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

    // TODO - VERIFY
    final dto =
        User(name: data['name'], email: data['email'], token: data['token']);

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

    final dto =
        User(name: data['name'], email: data['email'], token: data['token']);

    await _userRepository.changeUser(dto);

    _controller.add(AuthenticationStatus.authenticated);
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    _userRepository.logout();
  }

  void dispose() => _controller.close();
}
