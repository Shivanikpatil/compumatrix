import 'package:flutter/material.dart';
import '../../data/models/service_model.dart';
import '../../domain/repositories/service_repository.dart';

class ServiceProvider extends ChangeNotifier {
  final ServiceRepository serviceRepository;

  ServiceProvider({required this.serviceRepository});

  List<ActiveService> _services = [];
  List<ActiveService> get services => _services;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchActiveServices() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _services = await serviceRepository.getActiveServices();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
