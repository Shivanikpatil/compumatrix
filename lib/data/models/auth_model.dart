class LoginRequest {
  final String mobile;

  LoginRequest({required this.mobile});

  Map<String, dynamic> toJson() => {'mobile': mobile};
}

class VerifyOtpRequest {
  final String mobile;
  final String otp;

  VerifyOtpRequest({required this.mobile, required this.otp});

  Map<String, dynamic> toJson() => {
    'mobile': mobile,
    'otp': otp,
  };
}

class AuthResponse {

  final String? accessToken;
  final String? refreshToken;
  final String? message;

  AuthResponse({
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  factory AuthResponse.fromJson(
      Map<String, dynamic> json) {

    return AuthResponse(

      accessToken:
      json['data']?['accessToken'],

      refreshToken:
      json['data']?['refreshToken'],

      message:
      json['message'],
    );
  }
}