// lib/data/datasources/service_remote_datasource.dart
import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/service_model.dart';

class ServiceRemoteDataSource {
  final Dio _dio = DioClient.getInstance();

  Future<List<ServiceModel>> getActiveServices() async {
    try {
      final response = await _dio.get(ApiConstants.activeServices);
      
      // The API returns { "data": { "data": [...] } }
      final outer = response.data['data'] as Map<String, dynamic>?;
      final data = (outer?['data'] as List?) ?? [];

      return data
          .map((json) => ServiceModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch services',
      );
    }
  }
}
