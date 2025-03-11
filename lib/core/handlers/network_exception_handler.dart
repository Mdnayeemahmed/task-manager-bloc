import 'package:dio/dio.dart';

import '../network_executor/network_response.dart';

class NetworkExceptionHandler {
  static NetworkResponse handle(Exception e) {
    if (e is DioException) {
      switch (e.response?.statusCode) {
        case 401:
          return NetworkResponse(
              401, e.response?.data, e.response?.headers, 'Un-authorize');
        default:
          return NetworkResponse(
            e.response?.statusCode ?? -1,
            e.response?.data ??
                {
                  'success': false,
                  'message': 'Something went wrong',
                  'response_code': -1
                },
            e.response?.headers ?? {},
            e.response?.statusMessage ?? '',
          );
      }
    } else {
      return NetworkResponse(
        -1,
        {
          'success': false,
          'message': 'Something went wrong',
          'response_code': -1
        },
        {},
        '',
      );
    }
  }
}