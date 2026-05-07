import '../../domain/repositories/vehicle_repository.dart';
import '../datasources/vehicle_remote_datasource.dart';
import '../models/vehicle_model.dart';

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleRemoteDataSource remoteDataSource;

  VehicleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Vehicle>> getVehicles() async {
    return await remoteDataSource.getVehicles();
  }

  @override
  Future<void> addVehicle(Vehicle vehicle, String? imagePath) async {
    await remoteDataSource.addVehicle(vehicle, imagePath);
  }

  @override
  Future<void> deleteVehicle(String vehicleId) async {
    await remoteDataSource.deleteVehicle(vehicleId);
  }
}
