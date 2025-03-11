// class NetworkResponse {
//   final int statusCode;
//   final bool isSuccess;
//   final Map<String, dynamic>? responseData;
//   final String errorMessage;
//
//   NetworkResponse(
//      this.isSuccess,
//      this.statusCode,
//     this.responseData,
//     this.errorMessage = 'Something went wrong',
//   );
// }
class NetworkResponse {
  NetworkResponse(
      this.statusCode,
      this.body,
      this.header,
      this.statusMessage,
      );

  final int statusCode;
  final String statusMessage;
  final dynamic body;
  final dynamic header;
}