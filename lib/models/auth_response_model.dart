import 'user_model.dart';

class AuthResponse {
  bool success;
  String? message;
  User? user;
  String? token;

  AuthResponse({
    required this.success,
    required this.message,
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'],
      message: json['message'],
      user: json['data'] != null ? User.fromJson(json['data']) : null,
      token: json['token'],
    );
  }
}
