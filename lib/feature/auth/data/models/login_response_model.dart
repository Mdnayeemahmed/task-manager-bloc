import 'package:task_manager_ostad/feature/auth/data/models/user_model.dart';

class LoginResponseModel {
  final String status;
  final String token;
  final UserModel user;

  LoginResponseModel({
    required this.status,
    required this.token,
    required this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] ?? 'failed',
      token: json['token'] ?? '',
      user: UserModel.fromJson(json['data'] ?? {}),
    );
  }
}
