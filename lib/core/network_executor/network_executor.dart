import 'package:dio/dio.dart';


import '../handlers/network_exception_handler.dart';
import 'network_response.dart';

class NetworkExecutor {
  final Dio _dio;

  NetworkExecutor(this._dio);

  Future<NetworkResponse> getRequest({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    Options? options,
  }) async {
    Response? response;
    try {
      response = await _dio.get(
        path,
        queryParameters: queryParams,
        options: options,
      );
      return NetworkResponse(
        response.statusCode ?? -1,
        response.data,
        response.headers,
        response.statusMessage ?? '',
      );
    } catch (e) {
      return NetworkExceptionHandler.handle(e as Exception);
    }
  }

  Future<NetworkResponse> postRequest({
    required String path,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? headers,
    dynamic data,
    Options? options,
  }) async {
    Response? response;
    try {
      response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParams,
        options: options,
      );
      return NetworkResponse(
        response.statusCode ?? -1,
        response.data,
        response.headers,
        response.statusMessage ?? '',
      );
    } catch (e) {
      return NetworkExceptionHandler.handle(e as Exception);
    }
  }

  Future<NetworkResponse> putRequest({
    required String path,
    Map<String, dynamic>? queryParams,
    dynamic data,
    Options? options,
  }) async {
    Response? response;
    try {
      response = await _dio.put(path,
          queryParameters: queryParams, options: options, data: data);
      return NetworkResponse(
        response.statusCode ?? -1,
        response.data,
        response.headers,
        response.statusMessage ?? '',
      );
    } catch (e) {
      return NetworkExceptionHandler.handle(e as Exception);
    }
  }

  Future<NetworkResponse> patchRequest({
    required String path,
    Map<String, dynamic>? queryParams,
    Options? options,
    dynamic data,
  }) async {
    Response? response;
    try {
      response = await _dio.patch(path,
          queryParameters: queryParams, options: options, data: data);
      return NetworkResponse(
        response.statusCode ?? -1,
        response.data,
        response.headers,
        response.statusMessage ?? '',
      );
    } catch (e) {
      return NetworkExceptionHandler.handle(e as Exception);
    }
  }

  Future<NetworkResponse> deleteRequest({
    required String path,
    Map<String, dynamic>? queryParams,
    dynamic data,
    Options? options,
  }) async {
    Response? response;
    try {
      response = await _dio.delete(path,
          queryParameters: queryParams, options: options, data: data);
      return NetworkResponse(
        response.statusCode ?? -1,
        response.data,
        response.headers,
        response.statusMessage ?? '',
      );
    } catch (e) {
      return NetworkExceptionHandler.handle(e as Exception);
    }
  }
}