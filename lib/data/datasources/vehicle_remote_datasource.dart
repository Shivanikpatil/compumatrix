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

  /// POST /consumer-auth/  → multipart form with image + fields
  Future<void> addVehicle({
    required String vehicleName,
    required String regNo,
    required String vehicleType,  // must be "two_wheeler" or "four_wheeler"
    required File imageFile,
  }) async {
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
  }

  /// DELETE /consumer-auth/{id}
  Future<void> deleteVehicle(String vehicleId) async {
    await _dio.delete('${ApiConstants.vehicles}$vehicleId');
  }
}
