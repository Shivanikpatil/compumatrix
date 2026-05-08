// lib/domain/repositories/auth_repository.dart
abstract class AuthRepository {
  Future<void> requestOtp(String mobile);
  Future<String> verifyOtp(String mobile, String otp);
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> logout();
}
