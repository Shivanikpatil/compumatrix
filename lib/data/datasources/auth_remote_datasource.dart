import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/api_constants.dart';
import '../models/auth_model.dart';

class AuthRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  AuthRemoteDataSource(this.dio);

  Future<void> requestOtp(String mobile) async {
    debugPrint("Login URL: ${ApiConstants.loginRequestOtp} $mobile");

    try {
      await dio.post(ApiConstants.loginRequestOtp, data: {'mobile': mobile});
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to request OTP');
    }
  }

  Future<AuthResponse> verifyOtp(
      String mobile,
      String otp,
      ) async {

    final response = await dio.post(

      '/consumer-auth/login/verify-otp',

      data: {
        "mobile": mobile,
        "otp": otp,
      },
    );

    final authResponse =
    AuthResponse.fromJson(response.data);

    /// SAVE ACCESS TOKEN
    await storage.write(
      key: 'token',
      value: authResponse.accessToken ?? '',
    );

    /// CHECK TOKEN
    final savedToken =
    await storage.read(key: 'token');

    print("TOKEN SAVED => $savedToken");

    return authResponse;
  }
}
