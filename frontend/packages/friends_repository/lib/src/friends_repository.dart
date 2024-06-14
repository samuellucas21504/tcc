import 'package:authentication_repository/authentication_repository.dart';
import 'package:dio/dio.dart';
import 'package:friends_repository/models/friend_dto.dart';
import 'package:friends_repository/src/config/constants.dart';
import 'package:friends_repository/src/extensions/dio_extensions.dart';

class FriendsRepository {
  FriendsRepository(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository;

  final AuthenticationRepository _authenticationRepository;

  Future<FriendDTO> getFriends() async {
    final dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();

    dio.setBearerToken(bearerToken);

    final response = await dio.get('${Constants.url}');

    return FriendDTO.fromMap(response.data);
  }

  Future sendFriendRequest(String email) async {
    final dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();

    dio.setBearerToken(bearerToken);

    final response =
        await dio.post('${Constants.url}/request', data: {"email": email});

    print(response.statusCode);
  }

  Future handleFriendRequest(String email, bool accepted) async {
    final dio = Dio();
    final bearerToken = await _authenticationRepository.getBearerToken();

    dio.setBearerToken(bearerToken);

    final endpoint = accepted ? 'accept' : 'refuse';
    print(endpoint);
    await dio
        .post('${Constants.url}/request/$endpoint', data: {"email": email});
  }
}
