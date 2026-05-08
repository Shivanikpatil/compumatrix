import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../core/network/secure_storage.dart';
import '../../data/models/service_model.dart';

abstract class ServiceRepository {
  Dio _dio = Dio();
  Future<List<ActiveService>> getActiveServices() async {
    try {
      final token = await SecureStorageService.getToken();

      final response = await _dio.get(
        ApiConstants.activeServices,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final List data = response.data['data']['data'] ?? [];

      return data
          .map((json) => ActiveService.fromJson(json))
          .toList();

    } on DioException catch (e) {

      print("ERROR => ${e.response?.data}");

      throw Exception(
        e.response?.data['message'] ??
            'Failed to fetch services',
      );
    }
  }}
