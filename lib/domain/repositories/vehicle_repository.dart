import '../../data/models/vehicle_model.dart';

abstract class VehicleRepository {
  Future<List<Vehicle>> getVehicles();
  Future<void> addVehicle(Vehicle vehicle, String? imagePath);
  Future<void> deleteVehicle(String vehicleId);
}
