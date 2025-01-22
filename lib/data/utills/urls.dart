import 'dart:core';

class Urls {
  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static const String signUpUrl = '$_baseUrl/registration';
  static const String signInUrl = '$_baseUrl/login';
  static const String createTaskUrl = '$_baseUrl/createTask';
  static const String taskCountByStatusUrl = '$_baseUrl/taskStatusCount';
  static String taskListByStatusUrl(String status) =>
      '$_baseUrl/listTaskByStatus/$status';
  static const String updateProfileUrl = '$_baseUrl/profileUpdate';

}
