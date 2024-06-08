import 'dart:async';
import 'dart:convert';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:habit_repository/habit_repository.dart';
import 'package:habit_repository/src/config/constants.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:user_repository/user_repository.dart';

class HabitRepository {
  final _userRepository;
  final _authenticationRepository;
  final _storageRepository;

  HabitRepository({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
    required StorageRepository storageRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        _storageRepository = storageRepository;

  Habit? _habit;

  Future<void> register({required String objective}) async {
    final _dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();
    _dio.options.headers["Authorization"] = bearerToken;
    final body = Habit(reason: objective);

    Response response =
        await _dio.post('${Constants.url}/habits', data: body.toJson());

    try {
      final user = await _userRepository.getUser();
      final data = response.data;

      final habit = Habit(
        reason: data['reason'],
        motivation: data['motivation'],
      );

      _saveHabit(habit);
      _userRepository.changeUser(user!.copyWith(habitRegistered: true));
      _authenticationRepository.userAddedHabit();
    } catch (e) {
      print(e);
    }
  }

  Future fetchHabit() async {
    final _dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();
    _dio.options.headers["Authorization"] = bearerToken;

    Response response = await _dio.get('${Constants.url}/habits');
    final data = response.data;

    final habit = Habit(
      reason: data['reason'],
      motivation: data['motivation'],
    );
    _saveHabit(habit);
  }

  Future<List<HabitRecord>> fetchRecords(int month, int year) async {
    final _dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();

    _dio.options.headers["Authorization"] = bearerToken;

    Response response = await _dio.get(
      '${Constants.url}/habits/records',
      data: {
        'month': month,
        'year': year,
      },
    );
    final data = response.data;
    return HabitRecord.fromMapList(data);
  }

  Future record() async {
    final _dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();
    _dio.options.headers["Authorization"] = bearerToken;

    await _dio.post('${Constants.url}/habits/records');
  }

  Future<Habit?> getHabit() async {
    if (_habit != null) return _habit;
    var habit = await _storageRepository.read(Habit.key);

    if (habit == null || habit.isEmpty) return null;

    return Habit.fromJson(habit);
  }

  void _saveHabit(Habit habit) {
    _habit = habit;
    _storageRepository.write(Habit.key, jsonEncode(habit.toJson()));
  }

  void logOut() {
    _habit = null;
    _storageRepository.delete(Habit.key);
  }
}
