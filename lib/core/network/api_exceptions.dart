import 'package:dio/dio.dart';

import '../network/api_error.dart';

class ApiExceptions {
  static ApiError handleError(DioException error) {
    final data = error.response?.data;
    String message = 'Something went wrong';

    if (data is Map<String, dynamic>) {
      message =
          data['message'] ??
              data['error'] ??
              'Something went wrong';
      return ApiError(message: message);
    }


    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiError(
          message: 'Connection timeout',
        );

      case DioExceptionType.sendTimeout:
        return ApiError(
          message: 'Send timeout',
        );

      case DioExceptionType.receiveTimeout:
        return ApiError(
          message: 'Receive timeout',
        );

      case DioExceptionType.connectionError:
        return ApiError(
          message: 'No internet connection',
        );

      case DioExceptionType.cancel:
        return ApiError(
          message: 'Request cancelled',
        );

      default:
        return ApiError(
          message: 'Unexpected error occurred',
        );
    }
  }
}