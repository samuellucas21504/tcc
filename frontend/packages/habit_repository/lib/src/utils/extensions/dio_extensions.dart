import 'package:dio/dio.dart';

extension DioExtensions on Dio {
  void setBearerToken(String bearerToken) {
    this.options.headers['Authorization'] = bearerToken;
  }
}
