import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

class AuthProvider {
  final Dio httpClient;

  AuthProvider({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future authenticate({
    @required Map<String, dynamic> data,
  }) async {
    try {
      final Response response = await httpClient.post(
        'auth/login',
        data: data,
      );

      if (response.statusCode == 422) {
        throw Exception('Invalid email or password');
      }

      return response.data['token'];
    } catch (e) {
      // FIXME: handle error
      throw Exception(e.toString());
    }
  }
}