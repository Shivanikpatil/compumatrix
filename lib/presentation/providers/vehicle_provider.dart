// lib/presentation/providers/vehicle_provider.dart
import 'dart:io';
import 'package:flutter/material.dart';
import '../../data/datasources/vehicle_remote_datasource.dart';
import '../../data/models/vehicle_model.dart';

class VehicleProvider extends ChangeNotifier {
  final VehicleRemoteDataSource _dataSource = VehicleRemoteDataSource();

  List<VehicleModel> vehicles = [];
  bool isLoading = false;
  String? errorMessage;
  void setSelectedVehicleType(String type) {
    selectedVehicleType = type;
    notifyListeners();
  }
  // Add vehicle form state
  String? selectedVehicleType;  // "two_wheeler" or "four_wheeler"
  File? selectedImage;
  String vehicleName = '';
  String regNo = '';

  Future<void> loadVehicles() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      vehicles = await _dataSource.getVehicles();
    } catch (e) {
      errorMessage = 'Failed to load vehicles. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addVehicle() async {
    // ── Validation
    if (selectedVehicleType == null) {
      errorMessage = 'Please select a vehicle type.';
      notifyListeners();
      return false;
    }
    if (selectedImage == null) {
      errorMessage = 'Please add a vehicle image.';
      notifyListeners();
      return false;
    }
    if (regNo.trim().isEmpty) {
      errorMessage = 'Registration number is required.';
      notifyListeners();
      return false;
    }

    // ── API call
    errorMessage = null;        // clear any previous error
    isLoading = true;
    notifyListeners();

    try {
      await _dataSource.addVehicle(
        vehicleName: vehicleName,
        regNo: regNo,
        vehicleType: selectedVehicleType!,
        imageFile: selectedImage!,
      );
      await loadVehicles();
      _resetForm();
      return true;
    } catch (e) {
      // Show the real message thrown from the data source
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      return false;
    } finally {
      // ✅ Always reset loading — was missing on success path
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> deleteVehicle(String vehicleId) async {
    try {
      await _dataSource.deleteVehicle(vehicleId);
      vehicles.removeWhere((v) => v.id == vehicleId);
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to delete vehicle.';
      notifyListeners();
    }
  }

  void setVehicleType(String type) {
    selectedVehicleType = type;
    notifyListeners();
  }

  void setImage(File image) {
    selectedImage = image;
    notifyListeners();
  }

  void setVehicleName(String name) {
    vehicleName = name;
    notifyListeners();
  }

  void setRegNo(String reg) {
    regNo = reg;
    notifyListeners();
  }

  void _resetForm() {
    selectedVehicleType = null;
    selectedImage = null;
    vehicleName = '';
    regNo = '';
  }
}
