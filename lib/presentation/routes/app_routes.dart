import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/otp_verification_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/vehicles/add_vehicle_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String addVehicle = '/add-vehicle';

  static Map<String, WidgetBuilder> get routes => {
    login: (context) => const LoginScreen(),
    otp: (context) => const OtpVerificationScreen(),
    home: (context) => const HomeScreen(),
    addVehicle: (context) => const AddVehicleScreen(),
  };
}
