import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/network/secure_storage.dart';
import '../../data/models/service_model.dart';
import '../../domain/repositories/service_repository.dart';
//
// class ServiceProvider extends ChangeNotifier {
//   final ServiceRepository serviceRepository;
//
//   ServiceProvider({required this.serviceRepository});
//
//   List<ActiveService> _services = [];
//   List<ActiveService> get services => _services;
//
//   bool _isLoading = false;
//   bool get isLoading => _isLoading;
//
//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;
//
//   Future<void> fetchActiveServices() async {
//     _isLoading = true;
//     _errorMessage = null;
//     notifyListeners();
//
//     try {
//       _services = await serviceRepository.getActiveServices();
//     } catch (e) {
//       _errorMessage = e.toString();
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }
// }
// // lib/providers/service_provider.dart

enum ServiceStatus { idle, loading, success, error }

class ServiceProvider extends ChangeNotifier {
  List<ServiceModel> _services = [];
  ServiceStatus _status = ServiceStatus.idle;
  String _errorMessage = '';
  int _selectedTab = 0; // 0 = Fixed Price, 1 = Get a Quote

  List<ServiceModel> get services => _services;
  ServiceStatus get status => _status;
  String get errorMessage => _errorMessage;
  int get selectedTab => _selectedTab;

  static const String _baseUrl =
      'https://wa-peke-api.demohub.tech/api/v1/active-services/services';

  // Replace with your actual bearer token
  // static const String _token = 'YOUR_BEARER_TOKEN_HERE';

  void setTab(int index) {
    _selectedTab = index;
    notifyListeners();
  }

  Future<void> fetchServices() async {
    _status = ServiceStatus.loading;
    _errorMessage = '';
    notifyListeners();

    // Bug 1 fixed: null-safe check instead of token!
    // Bug 2 fixed: return + notifyListeners() so execution stops here
    // final token = await SecureStorageService.getToken();
    // if (token == null || token.isEmpty) {
    //   _errorMessage = 'Token is empty';
    //   _status = ServiceStatus.error;
    //   notifyListeners();
    //   return;
    // }

    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY5ZjBhZThkYjU3NDlhYWRlODUxOTQyOCIsInJvbGUiOiJjb25zdW1lciIsImZ1bGxfbmFtZSI6IlNvaGFtIiwibW9iaWxlIjoiODg1NTIyMzMiLCJpc19hY3RpdmUiOnRydWUsImlhdCI6MTc3ODE3Njk1NSwiZXhwIjoxNzc4MjYzMzU1fQ.7W-vVSfi6wzXjnzIEsi8sZkmPbBM9HvQecclm4kY0ao',
          // 'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = json.decode(response.body);

        // Bug 3 fixed: safe null-aware access instead of chained [][]
        final outer = body['data'] as Map<String, dynamic>?;
        final List<dynamic> data = (outer?['data'] as List?) ?? [];

        _services = data
            .whereType<Map<String, dynamic>>()
            .map((e) => ServiceModel.fromJson(e))
            .toList();
        _status = ServiceStatus.success;
      } else {
        _errorMessage = 'Failed to load services (${response.statusCode})';
        _status = ServiceStatus.error;
      }
    } catch (e) {
      _errorMessage = 'Network error: ${e.toString()}';
      _status = ServiceStatus.error;
    }

    notifyListeners();
  }}
