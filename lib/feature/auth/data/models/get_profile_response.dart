import 'package:task_manager_ostad/feature/auth/data/models/user_model.dart';

class GetProfileResponseModel {
  final String status;
  final UserModel user;

  GetProfileResponseModel({
    required this.status,
    required this.user,
  });

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return GetProfileResponseModel(
      status: json['status'] ?? 'failed',
      user: UserModel.fromJson(json['data'] is List && json['data'].isNotEmpty
          ? json['data'][0]
          : {}),
    );
  }
}
