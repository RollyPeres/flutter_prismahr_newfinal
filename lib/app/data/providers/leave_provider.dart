import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class LeaveProvider {
  final Dio httpClient = Request.dio;

  Future<List<Leave>> fetch() async {
    try {
      final Response response = await httpClient.get('leaves');
      final List list = response.data['data'] as List;

      if (response.data['data'] == null) {
        return const <Leave>[];
      }

      return list.map((l) => Leave.fromJson(l)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> store(Map<String, dynamic> data) async {
    try {
      final Response response = await httpClient.post(
        'leaves',
        data: FormData.fromMap(data),
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );

      if (response.statusCode == 422) {
        return LeaveFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      return Leave.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
