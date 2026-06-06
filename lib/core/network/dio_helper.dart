import 'package:dio/dio.dart';
import '../utils/cache_helper.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
    BaseOptions(
      baseUrl: 'https://ecommerce.routemisr.com/api/v1/',
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {

          final token = CacheHelper.getData(key: 'userToken');

          print('--- MY TOKEN FROM CACHE: $token ---');

          if (token != null && token.isNotEmpty) {
            options.headers['token'] = token;
          }

          return handler.next(options);
        },
        onError: (error, handler) {

          print('Dio Error: ${error.response?.data}');

          return handler.next(error);
        },
      ),
    );
  }
}