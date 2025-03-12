import 'package:dartz/dartz.dart';
import 'package:sm_app/core/domain/data/model/api_failure.dart';
import 'package:sm_app/core/domain/entities/failure.dart';
import 'package:sm_app/core/network_executor/network_executor.dart';
import 'package:sm_app/features/auth/data/models/login_model.dart';
import 'package:sm_app/features/auth/data/models/token_model.dart';
import 'package:sm_app/features/auth/data/repositories/auth_local_data_source.dart';
import 'package:sm_app/features/auth/domain/entities/login.dart';
import 'package:sm_app/features/auth/domain/entities/token.dart';

import '../../../../core/network_executor/network_executor.dart';
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

  Future<Either<Failure, Login>> signIn(
      String userName, String password) async {
    final response = await _networkExecutor.postRequest(
      path: _loginUrl,
      data: {
        'username': userName,
        'password': password,
      },
    );
    final responseBody = response.body as Map<String, dynamic>;
    if (responseBody['status'] == 'success') {
      final model = LoginModel.fromJson(response.body);
      final login = model.toEntity();
      await _authLocalDataSource.saveUserTokens(
        login.loginData.token.accessToken,
        login.loginData.token.refreshToken,
      );

      return Right(login);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<Either<Failure, Token>> refreshToken(String token) async {
    final response = await _networkExecutor
        .postRequest(path: _refreshTokenUrl, data: {'refresh_token': token});
    if (response.statusCode == 200) {
      final token = TokenModel.fromJson(response.body).toEntity();
      await _authLocalDataSource.saveUserTokens(
        token.accessToken,
        token.refreshToken,
      );
      return Right(token);
    } else {
      return Left(ApiFailure.fromJson(response.body).toEntity());
    }
  }

  Future<String?> getUserAccessToken() {
    return _authLocalDataSource.getUserAccessToken();
  }

  Future<String?> getRefreshToken() {
    return _authLocalDataSource.getUserRefreshToken();
  }

  Future<void> clearUserData() async {
    await _authLocalDataSource.clearUserData();
  }
}