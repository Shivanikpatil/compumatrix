import '../../repositories/vehicle_repository.dart';
import '../../../data/models/vehicle_model.dart';

class GetVehiclesUseCase {
  final VehicleRepository repository;

  GetVehiclesUseCase(this.repository);

  Future<List<Vehicle>> execute() async {
    return await repository.getVehicles();
  }
}
