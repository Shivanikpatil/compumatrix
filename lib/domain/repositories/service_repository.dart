// lib/domain/repositories/service_repository.dart
import '../../data/models/service_model.dart';

abstract class ServiceRepository {
  Future<List<ServiceModel>> getActiveServices();
}
