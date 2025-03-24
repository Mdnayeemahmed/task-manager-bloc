import 'package:dartz/dartz.dart';
import 'package:task_manager_ostad/feature/auth/domain/entites/user.dart';

import '../../../../core/domain/data/model/api_failure.dart';
import '../../../../core/domain/domain.dart';
import '../../../../core/network_executor/network_executor.dart';
import '../models/get_profile_response.dart';
import '../models/login_response_model.dart';
import 'auth_local_data_source.dart';

class AuthRepository {
  AuthRepository(
    this._networkExecutor,
    this._authLocalDataSource,
  );

  final String _loginUrl = 'login';
  final String _getProfileInformation = 'ProfileDetails';
  final String _forgotPasswordUrl = 'RecoverVerifyEmail';
  final String _verifyOtpUrl = 'RecoverVerifyOTP';
  final String _resetPassword = 'RecoverResetPass';
  final String _updateProfileUrl = 'ProfileUpdate';

  final NetworkExecutor _networkExecutor;
  final AuthLocalDataSource _authLocalDataSource;

  Future<Either<Failure, User>> signIn(
      String userEmail, String password) async {
    final response = await _networkExecutor.postRequest(
      path: _loginUrl,
      data: {
        'email': userEmail,
        'password': password,
      },
    );
    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      final loginResponse = LoginResponseModel.fromJson(responseBody);
      final user = loginResponse.user.toEntity();

      // ✅ Save token & user data locally
      await _authLocalDataSource.saveUserData(
        loginResponse.token,
        loginResponse.user,
      );

      return Right(user);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<Either<Failure, bool>> resetEmailRequest(String userEmail) async {
    String url = "$_forgotPasswordUrl/$userEmail";

    final response = await _networkExecutor.getRequest(
      path: url,
    );
    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      return const Right(true);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<Either<Failure, bool>> signUp(String userEmail, String firstName,
      String lastName, String mobile, String password) async {
    String url = "$_forgotPasswordUrl/$userEmail";

    final response = await _networkExecutor.postRequest(
      path: url,
      data: {
        "email": userEmail,
        "firstName": firstName,
        "lastName": lastName,
        "mobile": mobile,
        "password": password,
        "photo": ""
      },
    );
    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      return const Right(true);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<Either<Failure, bool>> verifyOtp(String userEmail, String otp) async {
    String url = "$_verifyOtpUrl/$userEmail/$otp";

    final response = await _networkExecutor.getRequest(
      path: url,
    );
    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      return const Right(true);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<Either<Failure, bool>> resetPassword(
      String userEmail, String otp, String password) async {
    final response = await _networkExecutor.postRequest(
      path: _resetPassword,
      data: {
        'email': userEmail,
        'OTP': otp,
        'password': password,
      },
    );
    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      return const Right(true);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<Either<Failure, bool>> updateProfile({
    required String email,
    required String firstName,
    required String lastName,
    required String mobile,
    String? password,
    String? photo, // base64 encoded image string if available
  }) async {
    // Build the request data
    final Map<String, dynamic> requestBody = {
      "email": email.trim(),
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "mobile": mobile.trim(),
    };

    if (photo != null && photo.isNotEmpty) {
      requestBody['photo'] = photo;
    }

    if (password != null && password.isNotEmpty) {
      requestBody['password'] = password;
    }

    final response = await _networkExecutor.postRequest(
      path: _updateProfileUrl,
      data: requestBody,
    );

    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      await getProfileInfomation();
      // Optionally, update the local user data if necessary
      // For example, re-save the user info locally if it is returned
      return const Right(true);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<Either<Failure, User>> getProfileInfomation() async {
    final response = await _networkExecutor.getRequest(
      path: _getProfileInformation,
    );
    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      final loginResponse = GetProfileResponseModel.fromJson(responseBody);
      final user = loginResponse.user.toEntity();

      // ✅ Save token & user data locally
      await _authLocalDataSource.saveUserModel(
        loginResponse.user,
      );
      _authLocalDataSource.getUserInformation();

      return Right(user);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  // Future<Either<Failure, Token>> refreshToken(String token) async {
  //   final response = await _networkExecutor
  //       .postRequest(path: _refreshTokenUrl, data: {'refresh_token': token});
  //   if (response.statusCode == 200) {
  //     final token = TokenModel.fromJson(response.body).toEntity();
  //     await _authLocalDataSource.saveUserTokens(
  //       token.accessToken,
  //       token.refreshToken,
  //     );
  //     return Right(token);
  //   } else {
  //     return Left(ApiFailure.fromJson(response.body).toEntity());
  //   }
  // }

  Future<String?> getUserAccessToken() {
    return _authLocalDataSource.getUserToken();
  }

  Future<bool> isUserLogin() {
    return _authLocalDataSource.isUserLoggedIn();
  }

  Future<Map<String, dynamic>?> getUserInformation() {
    return _authLocalDataSource.getUserData();
  }

  Future<void> clearUserData() async {
    await _authLocalDataSource.clearUserData();
  }
}
