// lib/core/constants/api_constants.dart
class ApiConstants {
  static const String baseUrl = 'https://wa-peke-api.demohub.tech/api/v1/';
  static const String imageBaseUrl = 'https://wa-peke-api.demohub.tech/';

  // Auth
  static const String requestOtp = 'consumer-auth/login/request-otp';
  static const String verifyOtp  = 'consumer-auth/login/verify-otp';

  // Vehicles — GET list, POST add, DELETE /{id}
  static const String vehicles   = 'consumer-auth/';

  // Services
  static const String activeServices = 'active-services/services';
}
