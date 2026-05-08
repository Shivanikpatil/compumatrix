// lib/data/datasources/auth_remote_datasource.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../../core/storage/secure_storage.dart';

class AuthRemoteDataSource {
  final Dio _dio = DioClient.getInstance();

  Future<void> requestOtp(String mobile) async {
    try {
      await _dio.post(ApiConstants.requestOtp, data: {'mobile': mobile});
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e));
    } catch (e) {
      throw Exception('Failed to request OTP');
    }
  }

  Future<String> verifyOtp(String mobile, String otp) async {
    try {
      final response = await _dio.post(
        ApiConstants.verifyOtp,
        data: {
          'mobile': mobile,
          'otp': otp,
        },
      );
      
      debugPrint('Verify OTP Response: ${response.data}');

      final dynamic responseBody = response.data;
      String? token;

      if (responseBody is Map) {
        final dynamic dataField = responseBody['data'];
        if (dataField is Map) {
          // Check common token keys
          token = dataField['token']?.toString() ?? 
                  dataField['accessToken']?.toString() ?? 
                  dataField['auth_token']?.toString();
        } else if (dataField is String) {
          token = dataField;
        }
      }

      if (token == null || token.isEmpty) {
        debugPrint('Token not found in response: $responseBody');
        throw Exception('Authentication token not found in server response');
      }

      await SecureStorage.saveToken(token);
      return token;
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e));
    } catch (e) {
      debugPrint('Unexpected error during OTP verify: $e');
      throw Exception('An unexpected error occurred during verification');
    }
  }

  String _getErrorMessage(DioException e) {
    if (e.response?.data is Map) {
      final Map data = e.response!.data;
      return data['message']?.toString() ?? 
             data['error']?.toString() ?? 
             'Server error: ${e.response?.statusCode}';
    }
    return e.message ?? 'A network error occurred';
  }
}
