// lib/domain/usecases/vehicles/get_vehicles_usecase.dart
import '../../repositories/vehicle_repository.dart';
import '../../../data/models/vehicle_model.dart';

class GetVehiclesUseCase {
  final VehicleRepository repository;

  GetVehiclesUseCase(this.repository);

  Future<List<VehicleModel>> execute() async {
    return await repository.getVehicles();
  }
}
