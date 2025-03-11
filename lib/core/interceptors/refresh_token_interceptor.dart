import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../app/app_config/app_configurations.dart';

class RefreshTokenInterceptor extends Interceptor {
  final VoidCallback onUnauthorized;
  final Future<bool> Function() refreshToken;
  final List<String> openUrls;
  final Dio dio;

  RefreshTokenInterceptor(
      {required this.onUnauthorized,
        required this.refreshToken,
        required this.openUrls,
        required this.dio});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 &&
        !openUrls.contains(err.response?.requestOptions.path)) {
      final refreshStatus = await refreshToken();
      if (refreshStatus) {
        handler.resolve(await _retry(err.response!.requestOptions));
        return;
      } else {
        onUnauthorized();
      }
    }
    super.onError(err, handler);
  }

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    super.onResponse(response, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    requestOptions.path =
        requestOptions.path.replaceAll(AppConfiguration.baseUrl, '');

    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}