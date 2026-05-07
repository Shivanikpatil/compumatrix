import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/secure_storage.dart';
import '../models/service_model.dart';

class ServiceRemoteDataSource {
  final Dio dio;

  ServiceRemoteDataSource(this.dio);

  Future<List<ActiveService>> getActiveServices() async {
    try {
      final token = await SecureStorageService.getToken();

      final response = await dio.get(
        ApiConstants.activeServices,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      final List data = response.data['data'] ?? [];

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
  }
}
