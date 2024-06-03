import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageRepository {
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );
  static final _storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  Future write(String key, String value) async {
    return await _storage.write(key: key, value: value);
  }

  Future delete(String key) {
    return _storage.delete(key: key);
  }
}
