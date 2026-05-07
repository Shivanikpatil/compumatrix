import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/network/dio_client.dart';
import '../data/datasources/auth_remote_datasource.dart';
import '../data/datasources/vehicle_remote_datasource.dart';
import '../data/datasources/service_remote_datasource.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../data/repositories/vehicle_repository_impl.dart';
import '../data/repositories/service_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/repositories/vehicle_repository.dart';
import '../domain/repositories/service_repository.dart';

class InjectionContainer {
  static late final Dio dio;
  static late final FlutterSecureStorage storage;
  
  static late final AuthRepository authRepository;
  static late final VehicleRepository vehicleRepository;
  static late final ServiceRepository serviceRepository;

  static Future<void> init() async {
    storage = const FlutterSecureStorage();
    final dioClient = DioClient();
    dio = dioClient.dio;

    // Data sources
    final authRemoteDataSource = AuthRemoteDataSource(dio);
    final vehicleRemoteDataSource = VehicleRemoteDataSource(dio);
    final serviceRemoteDataSource = ServiceRemoteDataSource(dio);

    // Repositories
    authRepository = AuthRepositoryImpl(
      remoteDataSource: authRemoteDataSource,
      storage: storage,
    );
    vehicleRepository = VehicleRepositoryImpl(
      remoteDataSource: vehicleRemoteDataSource,
    );
    serviceRepository = ServiceRepositoryImpl(
      remoteDataSource: serviceRemoteDataSource,
    );
  }
}
