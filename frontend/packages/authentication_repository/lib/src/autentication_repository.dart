import 'dart:async';

import 'package:authentication_repository/src/config/constants.dart';
import 'package:authentication_repository/src/models/register/request_register_dto.dart';
import 'package:authentication_repository/src/models/register/response_register_dto.dart';
import 'package:dio/dio.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _dio = Dio();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<ResponseRegisterDTO> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final body =
        RequestRegisterDTO(name: name, email: email, password: password);

    Response response;
    try {
      response = await _dio.post('${Constants.url}/auth/register',
          data: body.toJson());

      final dto = ResponseRegisterDTO.fromResponse(response);

      _controller.add(AuthenticationStatus.authenticated);

      return dto;
    } on Exception catch (e) {
      print(e);
    }
    throw Exception('aaa');
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}
