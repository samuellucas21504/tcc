import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:friends_repository/models/friend.dart';
import 'package:friends_repository/src/config/constants.dart';
import 'package:friends_repository/src/extensions/dio_extensions.dart';

class FriendsRepository {
  FriendsRepository(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  Future<List<Friend>> getFriends() async {
    final dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();

    dio.setBearerToken(bearerToken);

    final response = await dio.get('${Constants.url}');

    final data = response.data;
    print(data);

    return (data.map((object) => Friend.fromMap(object)).toList())
        .cast<Friend>();
  }

  Future sendFriendRequest(String email) async {
    final dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();

    dio.setBearerToken(bearerToken);

    final response =
        await dio.post('${Constants.url}/request', data: {"email": email});

    print(response.statusCode);
  }
}
