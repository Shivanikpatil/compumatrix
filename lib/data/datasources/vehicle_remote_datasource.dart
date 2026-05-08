// lib/data/datasources/vehicle_remote_datasource.dart
import 'dart:io';
import 'package:dio/dio.dart';
import '../models/vehicle_model.dart';
import '../../core/constants/api_constants.dart';
import '../../core/network/dio_client.dart';

class VehicleRemoteDataSource {
  final Dio _dio = DioClient.getInstance();

  /// GET /consumer-auth/  → returns data array
  Future<List<VehicleModel>> getVehicles() async {
    final response = await _dio.get(ApiConstants.vehicles);
    final data = response.data['data'] as List<dynamic>;
    return data.map((e) => VehicleModel.fromJson(e)).toList();
  }

  Future<void> addVehicle({
    required String vehicleName,
    required String regNo,
    required String vehicleType,
    required File imageFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'vehicle_name': vehicleName,
        'reg_no': regNo,
        'vehicle_type': vehicleType,
        'vehicle_image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });
      await _dio.post(ApiConstants.vehicles, data: formData);
    } on DioException catch (e) {
      // Pull the server's message if available, else use a fallback
      final serverMsg = e.response?.data?['message'] as String?;
      throw Exception(serverMsg ?? 'Server error: ${e.response?.statusCode}');
    }
  }

  /// DELETE /consumer-auth/{id}
  Future<void> deleteVehicle(String vehicleId) async {
    await _dio.delete('${ApiConstants.vehicles}$vehicleId');
  }
}
