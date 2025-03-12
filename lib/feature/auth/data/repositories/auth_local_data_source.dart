import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_ostad/data/models/user_model.dart';

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

   Future<void> gerUserData()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    String? userData = sharedPreferences.getString(_userDataKey);
    accessToken =token;
    userModel = UserModel.fromJson(jsonDecode(userData!));
  }

   Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessTokenKey);
    if(token != null){
      await gerUserData();
      return true;
    }
    return false;
  }

   Future<void> clearUserData()async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }
}