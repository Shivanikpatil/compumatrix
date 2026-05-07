import 'package:flutter/material.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _mobile;
  String? get mobile => _mobile;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? value) {
    _errorMessage = value;
    notifyListeners();
  }

  Future<bool> requestOtp(String mobile) async {
    _setLoading(true);
    _setError(null);
    try {
      await authRepository.requestOtp(mobile);
      _mobile = mobile;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) async {
    if (_mobile == null) return false;

    _setLoading(true);
    _setError(null);

    try {

      await authRepository.verifyOtp(
        _mobile!,
        otp,
      );

      _setLoading(false);

      return true;

    } catch (e) {

      _setError(e.toString());

      _setLoading(false);

      return false;
    }
  }

  Future<void> logout() async {
    await authRepository.logout();
    notifyListeners();
  }

  Future<bool> isLoggedIn() async {
    final token = await authRepository.getToken();
    return token != null;
  }
}
