import 'package:dio/dio.dart';
import 'package:logger/logger.dart';


import '../../app/app_config/app_configurations.dart';
import '../../feature/common/presentation/blocs/global_auth_cubit.dart';

class DioInterceptor extends Interceptor {
  final Logger _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.path = AppConfiguration.baseUrl + options.path;
    options.data ??= <String, dynamic>{};
    if (GlobalAuthCubit.accessToken.isNotEmpty) {
      options.headers.addAll({
        'Authorization': 'Bearer ${GlobalAuthCubit.accessToken}',
      });
    }
    options.validateStatus = (status) {
      return status! >= 200 && status <= 204;
    };
    _logger.d(
      _requestLog(options),
    );
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(_errorResponseLog(err));
    super.onError(err, handler);
  }

  @override
  void onResponse(
      Response<dynamic> response,
      ResponseInterceptorHandler handler,
      ) {
    _logger.i(_responseLog(response));
    super.onResponse(response, handler);
  }

  String _requestLog(RequestOptions options) {
    return '''
      Request path => ${options.path}
      Request method => ${options.method}
      Request headers => ${options.headers}
      Request Query params => ${options.queryParameters}
      Request body => ${options.data}
    ''';
  }

  String _responseLog(Response<dynamic> response) {
    return '''
      Response Code => ${response.requestOptions.path}
      Response Code => ${response.statusCode}
      Response Headers => ${response.headers}
      Response Data => ${response.data}
    ''';
  }

  String _errorResponseLog(DioException response) {
    return '''
      Request Options => ${response.requestOptions.path}
      Response Error => ${response.response}
      Response Error => ${response.error}
      Response Stacktrace => ${response.stackTrace}
      Response Data => ${response.message}
    ''';
  }
}