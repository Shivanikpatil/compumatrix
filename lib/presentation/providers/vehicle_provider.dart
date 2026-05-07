import 'package:flutter/material.dart';
import '../../data/models/vehicle_model.dart';
import '../../domain/repositories/vehicle_repository.dart';

class VehicleProvider extends ChangeNotifier {
  final VehicleRepository vehicleRepository;

  VehicleProvider({required this.vehicleRepository});

  List<Vehicle> _vehicles = [];
  List<Vehicle> get vehicles => _vehicles;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchVehicles() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _vehicles = await vehicleRepository.getVehicles();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addVehicle(Vehicle vehicle, String? imagePath) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await vehicleRepository.addVehicle(vehicle, imagePath);
      await fetchVehicles();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteVehicle(String vehicleId) async {
    try {
      await vehicleRepository.deleteVehicle(vehicleId);
      _vehicles.removeWhere((v) => v.id == vehicleId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
