// lib/data/repositories/vehicle_repository_impl.dart
import 'dart:io';
import '../../domain/repositories/vehicle_repository.dart';
import '../datasources/vehicle_remote_datasource.dart';
import '../models/vehicle_model.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<VehicleModel>> getVehicles() async {
    return await remoteDataSource.getVehicles();
  }

  @override
  Future<void> addVehicle({
    required String vehicleName,
    required String regNo,
    required String vehicleType,
    required File imageFile,
  }) async {
    await remoteDataSource.addVehicle(
      vehicleName: vehicleName,
      regNo: regNo,
      vehicleType: vehicleType,
      imageFile: imageFile,
    );
  }

  @override
  Future<void> deleteVehicle(String vehicleId) async {
    await remoteDataSource.deleteVehicle(vehicleId);
  }
}
