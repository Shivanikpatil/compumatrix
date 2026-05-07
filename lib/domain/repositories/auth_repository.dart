import '../../data/models/auth_model.dart';

abstract class AuthRepository {
  Future<void> requestOtp(String mobile);
  Future<AuthResponse> verifyOtp(String mobile, String otp);
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> logout();
}
