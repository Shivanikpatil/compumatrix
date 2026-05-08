// lib/presentation/providers/service_provider.dart
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../../data/models/service_model.dart';

class ServiceProvider extends ChangeNotifier {
  final Dio _dio = DioClient.getInstance();

  List<ServiceModel> services = [];
  bool isLoading = false;
  String? errorMessage;
  int selectedTab = 0; // 0 = Fixed Price, 1 = Get a Quote

  void setTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  Future<void> fetchServices() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _dio.get(ApiConstants.activeServices);
      final outer = response.data['data'] as Map<String, dynamic>?;
      final data = (outer?['data'] as List?) ?? [];

      services = data
          .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      errorMessage = 'Failed to load services. Please try again.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
