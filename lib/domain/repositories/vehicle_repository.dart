// lib/domain/repositories/vehicle_repository.dart
import 'dart:io';
import '../../data/models/vehicle_model.dart';

abstract class VehicleRepository {
  Future<List<VehicleModel>> getVehicles();
  Future<void> addVehicle({
    required String vehicleName,
    required String regNo,
    required String vehicleType,
    required File imageFile,
  });
  Future<void> deleteVehicle(String vehicleId);
}
