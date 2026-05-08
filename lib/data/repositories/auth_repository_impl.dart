// lib/data/repositories/auth_repository_impl.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final FlutterSecureStorage storage;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.storage,
  });

  @override
  Future<void> requestOtp(String mobile) async {
    await remoteDataSource.requestOtp(mobile);
  }

  @override
  Future<String> verifyOtp(String mobile, String otp) async {
    final token = await remoteDataSource.verifyOtp(mobile, otp);
    await saveToken(token);
    return token;
  }

  @override
  Future<void> saveToken(String token) async {
    // Standardizing on 'auth_token' as used in SecureStorage and SplashScreen
    await storage.write(key: 'auth_token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }
}
