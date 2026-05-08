import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/network/secure_storage.dart';
import '../../data/models/vehicle_model.dart';

enum VehicleStatus { idle, loading, success, error }

class VehicleProvider extends ChangeNotifier {
  List<VehicleModel> _vehicles = [];
  VehicleStatus _status = VehicleStatus.idle;
  String _errorMessage = '';

  List<VehicleModel> get vehicles => _vehicles;
  VehicleStatus get status => _status;
  String get errorMessage => _errorMessage;

  static const String _baseUrl =
      'https://wa-peke-api.demohub.tech/api/v1/consumer-auth/';

  Future<void> fetchVehicles() async {
    _status = VehicleStatus.loading;
    _errorMessage = '';
    notifyListeners();

    // final token = await SecureStorageService.getToken();
    // if (token == null || token.isEmpty) {
    //   _errorMessage = 'Session expired. Please login again.';
    //   _status = VehicleStatus.error;
    //   notifyListeners();
    //   return;
    // }

    try {
      final response = await http
          .get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZjBhZThkYjU3NDlhYWRlODUxOTQyOCIsInJvbGUiOiJjb25zdW1lciIsImZ1bGxfbmFtZSI6IlNvaGFtIiwibW9iaWxlIjoiODg1NTIyMzMiLCJpc19hY3RpdmUiOnRydWUsImlhdCI6MTc3ODE3Njk1NSwiZXhwIjoxNzc4MjYzMzU1fQ.7W-vVSfi6wzXjnzIEsi8sZkmPbBM9HvQecclm4kY0ao',
          // 'Authorization': 'Bearer $token',
        },
      )
          .timeout(const Duration(seconds: 15));
      debugPrint('STATUS: ${response.statusCode} | URL: $_baseUrl | BODY: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> body =
        json.decode(response.body) as Map<String, dynamic>;

        final rawData = body['data'];
        final List<dynamic> data =
        (rawData is List) ? rawData : [];

        _vehicles = data
            .whereType<Map<String, dynamic>>()
            .map((e) => VehicleModel.fromJson(e))
            .toList();

        _status = VehicleStatus.success;
      } else {
        _errorMessage = 'Failed to fetch vehicles (HTTP ${response.statusCode})';
        _status = VehicleStatus.error;
        print(_errorMessage);
      }
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
      _status = VehicleStatus.error;
    }

    notifyListeners();
  }

  Future<void> deleteVehicle(String vehicleId) async {
    final token = await SecureStorageService.getToken();
    if (token == null || token.isEmpty) return;

    try {
      final response = await http
          .delete(
        Uri.parse(
            'https://wa-peke-api.demohub.tech/api/v1/consumer-auth/saved-vehicles/$vehicleId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        _vehicles.removeWhere((v) => v.id == vehicleId);
        notifyListeners();
      }
    } catch (_) {}
  }
}