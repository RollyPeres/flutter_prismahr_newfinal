import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/user_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class UserRepository {
  final Dio httpClient = Request.dio;

  Future<List<User>> fetch() async {
    try {
      final Response response = await httpClient.get('employees');
      final List list = response.data['data'] as List;

      return list.map((user) => User.fromJson(user)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
