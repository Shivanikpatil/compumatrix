import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_model.dart';

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
  Future<AuthResponse> verifyOtp(String mobile, String otp) async {
    final response = await remoteDataSource.verifyOtp(mobile, otp);
    if (response.accessToken != null) {
      await saveToken(response.accessToken!);
    }
    return response;
  }

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  @override
  Future<void> logout() async {
    await storage.delete(key: 'token');
  }
}
