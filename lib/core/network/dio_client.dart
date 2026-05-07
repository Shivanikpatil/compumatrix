import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/api_constants.dart';

class DioClient {

  final Dio _dio;

  final FlutterSecureStorage _storage =
  const FlutterSecureStorage();

  DioClient()
      : _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
      headers: {
        'Accept': 'application/json',
      },
    ),
  ) {

    _dio.interceptors.add(

      InterceptorsWrapper(

        onRequest: (options, handler) async {

          final token =
          await _storage.read(key: 'accessToken');

          print("TOKEN => $token");

          if (token != null && token.isNotEmpty) {

            options.headers['Authorization'] =
            'Bearer $token';
          }

          return handler.next(options);
        },

        onResponse: (response, handler) {

          return handler.next(response);
        },

        onError: (DioException e, handler) async {

          if (e.response?.statusCode == 401) {

            await _storage.delete(key: 'accessToken');

            print("Unauthorized - Token Removed");
          }

          return handler.next(e);
        },
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
      ),
    );
  }

  Dio get dio => _dio;
}