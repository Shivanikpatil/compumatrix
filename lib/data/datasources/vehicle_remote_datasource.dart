import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/vehicle_model.dart';

class VehicleRemoteDataSource {
  final Dio dio;

  VehicleRemoteDataSource(this.dio);

  Future<List<Vehicle>> getVehicles() async {
    try {
      final response = await dio.get(ApiConstants.vehicles);
      final List data = response.data['data'] ?? [];
      return data.map((json) => Vehicle.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch vehicles');
    }
  }

  Future<void> addVehicle(Vehicle vehicle, String? imagePath) async {
    try {
      FormData formData = FormData.fromMap({
        ...vehicle.toJson(),
        if (imagePath != null)
          'image': await MultipartFile.fromFile(imagePath),
      });

      await dio.post(ApiConstants.vehicles, data: formData);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to add vehicle');
    }
  }

  Future<void> deleteVehicle(String vehicleId) async {
    try {
      await dio.delete('${ApiConstants.vehicles}$vehicleId');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to delete vehicle');
    }
  }
}
