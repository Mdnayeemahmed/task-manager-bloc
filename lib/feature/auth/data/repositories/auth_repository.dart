import 'package:dartz/dartz.dart';
import 'package:task_manager_ostad/feature/auth/domain/entites/user.dart';

import '../../../../core/domain/data/model/api_failure.dart';
import '../../../../core/domain/domain.dart';
import '../../../../core/network_executor/network_executor.dart';
import '../models/login_response_model.dart';
import 'auth_local_data_source.dart';

class AuthRepository {
  AuthRepository(
      this._networkExecutor,
      this._authLocalDataSource,
      );

  final String _loginUrl = 'login';
  final String _refreshTokenUrl = 'refresh_token';

  final NetworkExecutor _networkExecutor;
  final AuthLocalDataSource _authLocalDataSource;

  Future<Either<Failure, User>>  signIn(
      String userName, String password) async {
    final response = await _networkExecutor.postRequest(
      path: _loginUrl,
      data: {
        'email': userName,
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

  Future<Map<String, dynamic>?> getUserInformation() {
    return _authLocalDataSource.getUserData();
  }

  Future<void> clearUserData() async {
    await _authLocalDataSource.clearUserData();
  }
}