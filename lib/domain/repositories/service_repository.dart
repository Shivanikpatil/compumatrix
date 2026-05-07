import '../../data/models/service_model.dart';

abstract class ServiceRepository {
  Future<List<ActiveService>> getActiveServices();
}
