import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_ostad/data/models/user_model.dart';
import 'package:task_manager_ostad/feature/auth/data/models/user_model.dart';

import '../../../../core/domain/data/model/api_failure.dart';
import '../../../../core/domain/entities/failure.dart';
import '../../domain/entites/user.dart';

class AuthLocalDataSource {
  static String? accessToken;
  static UserModel? userModel;

   final String _accessTokenKey = 'access-token';
   final String _userDataKey = 'user-data';
   Future<void> saveUserData(String token, UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, token);
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    accessToken = token;
    accessToken = accessToken;
    userModel = model;
  }

  Future<void> saveUserModel(UserModel model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userDataKey, jsonEncode(model.toJson()));
    accessToken = accessToken;
    userModel = model;
  }

  //  Future<void> gerUserData()async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? token = sharedPreferences.getString(_accessTokenKey);
  //   String? userData = sharedPreferences.getString(_userDataKey);
  //   accessToken =token;
  //   userModel = UserModel.fromJson(jsonDecode(userData!));
  // }

  Future<Map<String, dynamic>?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);

    if (token == null || userData == null) return null;

    return {
      "accessToken": token,
      "userModel": UserModel.fromJson(jsonDecode(userData)),
    };
  }

  // Future<User?> getUserInformation() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? userData = sharedPreferences.getString(_userDataKey);
  //
  //   if (userData != null) {
  //     // Assuming the stored data is in JSON format, you can decode it and return the UserEntity
  //     Map<String, dynamic> userJson = json.decode(userData);
  //     return User.fromJson(userJson);
  //   }
  //   return null; // Return null if no data is found
  // }

  Future<User> getUserInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString(_userDataKey);

    // If no user data is found, handle it appropriately (e.g., throw an exception or return a default User entity)
    if (userData == null) {
      throw Exception('No user data found');
    }

    // Decode the stored JSON data
    final loginResponse = UserModel.fromJson(jsonDecode(userData));

    log(loginResponse.toEntity().email);

    // Convert the UserModel to UserEntity and return
    return loginResponse.toEntity();
  }









  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);

    if (token != null) {
      await getUserData();
      return true;
    }

    return false;
  }

  Future<String?> getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(_accessTokenKey);
  }


  Future<void> clearUserData()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}