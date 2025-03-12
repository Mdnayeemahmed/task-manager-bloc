import '../../domain.dart';

class ApiSuccess {
  ApiSuccess({this.success, this.responseCode, this.message});

  ApiSuccess.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      success = json['success'] != null ? json['success'] as bool : null;
      responseCode =
      json['response_code'] != null ? json['response_code'] as int : null;
      final msg = json['message'];
      if (msg is String) {
        message = msg;
      } else if (msg is Map<String, dynamic>) {
        message = msg.toString();
      } else {
        message = null;
      }
    } else if (json is String) {
      message = json;
    } else {
      message = 'Unexpected error format.';
    }
  }

  bool? success;
  int? responseCode;
  String? message;

  Success toEntity() {
    return Success(message);
  }
}