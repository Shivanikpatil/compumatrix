// lib/presentation/providers/auth_provider.dart
import 'package:flutter/material.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../core/storage/secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRemoteDataSource _dataSource = AuthRemoteDataSource();

  bool isLoading = false;
  String? errorMessage;
  String? mobileNumber;

  Future<bool> requestOtp(String mobile) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await _dataSource.requestOtp(mobile);
      mobileNumber = mobile;
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    if (mobileNumber == null) return false;
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      await _dataSource.verifyOtp(mobileNumber!, otp);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await SecureStorage.clearAll();
    notifyListeners();
  }
}
