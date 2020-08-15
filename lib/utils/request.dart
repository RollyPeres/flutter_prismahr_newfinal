import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_prismahr/utils/interceptors/attach_token_interceptor.dart';

// import 'interceptors/logging_interceptor.dart';

class Request {
  static Dio get dio => _dio();

  static Dio _dio() {
    // Configure base options for dio package.
    final BaseOptions options = BaseOptions(
      baseUrl: DotEnv().env['API_URL'],
      connectTimeout: 5000,
      receiveTimeout: 5000,
      followRedirects: false,
      headers: {'X-Requested-With': 'XMLHttpRequest'},

      /// perceive as successful if status code is less than 500 (Server Error)
      /// so that the app doesn't break when there is any validation
      /// errors from the server.
      validateStatus: (statusCode) {
        return statusCode < 500;
      },
    );

    // Initiate dio with the provided options.
    Dio dio = Dio(options);

    // Add interceptors.
    dio.interceptors.add(AttachTokenInterceptor());
    // dio.interceptors.add(LoggingInterceptor());

    return dio;
  }
}
