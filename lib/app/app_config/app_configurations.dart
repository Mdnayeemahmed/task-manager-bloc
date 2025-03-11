class AppConfiguration {
  static const Duration connectionTimeOut = Duration(seconds: 300);
  static const Duration sendTimeOut = Duration(seconds: 300);
  static const Duration receiveTimeOut = Duration(seconds: 300);

  //**************dev server*******************
  static const String baseUrl = 'https://task.teamrabbil.com/api/v1';
  // static const String imageUrl = 'https://smbp-storage.s3.ap-southeast-1.amazonaws.com/';
}