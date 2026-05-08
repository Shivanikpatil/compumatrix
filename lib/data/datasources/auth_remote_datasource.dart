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
      
      final dynamic responseData = response.data;
      String? token;

      if (responseData != null && responseData is Map) {
        final dynamic dataField = responseData['data'];
        
        if (dataField != null) {
          if (dataField is Map) {
            token = dataField['token']?.toString() ?? 
                    dataField['accessToken']?.toString() ?? 
                    dataField['auth_token']?.toString();
          } else if (dataField is String) {
            token = dataField;
          }
        }
      }

      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found in server response');
      }

      await SecureStorage.saveToken(token);
      return token;
    } on DioException catch (e) {
      throw Exception(_getErrorMessage(e));
    } catch (e) {
      if (e is TypeError) {
        throw Exception('Data format error: ${e.toString()}');
      }
      throw Exception('An unexpected error occurred during verification');
    }
  }

  String _getErrorMessage(DioException e) {
    try {
      if (e.response?.data != null && e.response?.data is Map) {
        final Map data = e.response!.data;
        return data['message']?.toString() ?? 
               data['error']?.toString() ?? 
               'Server error: ${e.response?.statusCode}';
      }
    } catch (_) {}
    return e.message ?? 'A network error occurred';
  }
}
