// lib/di/injection_container.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
  static late final FlutterSecureStorage storage;
  
  static late final AuthRepository authRepository;
  static late final VehicleRepository vehicleRepository;
  static late final ServiceRepository serviceRepository;

  static Future<void> init() async {
    storage = const FlutterSecureStorage();

    // Data sources
    final authRemoteDataSource = AuthRemoteDataSource();
    final vehicleRemoteDataSource = VehicleRemoteDataSource();
    final serviceRemoteDataSource = ServiceRemoteDataSource();

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
