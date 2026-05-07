import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(
      key: 'accessToken',
      value: token,
    );
  }

  static Future<String?> getToken() async {
    return await _storage.read(
      key: 'accessToken',
    );
  }

  static Future<void> clearStorage() async {
    await _storage.deleteAll();
  }
}