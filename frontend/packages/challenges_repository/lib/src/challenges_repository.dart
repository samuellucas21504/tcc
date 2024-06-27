import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:challenges_repository/challenges_repository.dart';
import 'package:challenges_repository/src/config/constants.dart';
import 'package:challenges_repository/src/models/challenge_dto.dart';
import 'package:challenges_repository/src/utils/extensions/dio_extensions.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:user_repository/user_repository.dart';

class ChallengesRepository {
  final _authenticationRepository;

  ChallengesRepository({
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;

  Future<Challenge> register(String name, DateTime finishesAt) async {
    final _dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();
    _dio.setBearerToken(bearerToken);

    final body = {
      "name": name,
      "finishes_at": finishesAt.millisecondsSinceEpoch,
    };

    print(body);
    print(jsonEncode(body));

    Response response =
        await _dio.post('${Constants.url}', data: jsonEncode(body));

    try {
      final data = response.data;

      final habit = Challenge(
        name: data['name'],
        creator: User.fromMap(data['creator']),
      );

      return habit;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ChallengeDTO> getChallenges() async {
    final _dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();
    _dio.setBearerToken(bearerToken);

    Response response = await _dio.get('${Constants.url}');
    final data = response.data;
    print('@a ${data}');

    final challenge = ChallengeDTO(
      challenges: Challenge.fromMapList(data["challenges"]),
      requests: ChallengeRequest.fromMapList(data["requests"]),
    );

    return challenge;
  }

  Future<List<ChallengeRecord>> fetchRecords(
      int month, int year, String challengeId) async {
    final _dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();

    _dio.options.headers["Authorization"] = bearerToken;

    Response response = await _dio.get(
      '${Constants.url}/records',
      data: {
        'month': month,
        'year': year,
      },
    );
    final data = response.data;
    return ChallengeRecord.fromMapList(data);
  }

  Future record() async {
    final _dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();
    _dio.options.headers["Authorization"] = bearerToken;

    await _dio.post('${Constants.url}/records');
  }
}
