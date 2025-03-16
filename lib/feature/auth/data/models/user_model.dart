import '../../domain/entites/user.dart';

class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;

  UserModel({
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.photo,
  });

  // Computed full name
  String get fullName => '$firstName $lastName';

  // Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      mobile: json['mobile'],
      photo: json['photo'],
    );
  }

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'mobile': mobile,
      'photo': photo,
    };
  }

  // ✅ Convert UserModel to User entity
  User toEntity() {
    return User(
      email: email ?? '',
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      mobile: mobile ?? '',
      photo: photo ?? '',
    );
  }
}