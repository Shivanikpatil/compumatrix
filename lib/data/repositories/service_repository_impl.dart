import '../../domain/repositories/service_repository.dart';
import '../datasources/service_remote_datasource.dart';
import '../models/service_model.dart';

class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceRemoteDataSource remoteDataSource;

  ServiceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ActiveService>> getActiveServices() async {
    return await remoteDataSource.getActiveServices();
  }
}
