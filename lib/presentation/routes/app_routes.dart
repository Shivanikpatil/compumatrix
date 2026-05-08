// lib/presentation/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_verification_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/vehicles/add_vehicle_screen.dart';
import '../screens/vehicles/vehicle_list_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/profile/profile_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String vehicles = '/vehicles';
  static const String addVehicle = '/add-vehicle';
  static const String profile = '/profile';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    otp: (context) => const OtpVerificationScreen(),
    home: (context) => const HomeScreen(),
    vehicles: (context) => const MyVehiclesScreen(),
    addVehicle: (context) => const AddVehicleScreen(),
    profile: (context) => const ProfileScreen(),
  };
}
