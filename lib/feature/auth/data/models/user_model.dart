import '../../domain/entites/user.dart';

class UserModel {
  final User user; // ✅ Use User as a field inside UserModel

  UserModel({required this.user});

  // Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user: User(
        email: json['email'] ?? '',
        firstName: json['firstName'] ?? '',
        lastName: json['lastName'] ?? '',
        mobile: json['mobile'] ?? '',
        photo: json['photo'] ?? '',
      ),
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'mobile': user.mobile,
      'photo': user.photo,
    };
  }

  User toEntity() => user;

  // UserModel toEntity() => UserModel(
  //   user: userModel!.toEntity(),
  // );
}
