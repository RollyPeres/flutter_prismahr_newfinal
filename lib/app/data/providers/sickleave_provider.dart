import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/sickleave_form_validation_exception.dart';
import 'package:flutter_prismahr/app/data/models/sickleave_model.dart';
import 'package:flutter_prismahr/utils/request.dart';
import 'package:pretty_json/pretty_json.dart';

class SickleaveProvider {
  final Dio httpClient = Request.dio;

  Future<List<Sickleave>> fetch() async {
    try {
      final Response response = await httpClient.get('sickLeaves');

      if (response.data['data'] == null) {
        return const <Sickleave>[];
      }

      final List list = response.data['data'] as List;
      return list.map((s) => Sickleave.fromJson(s)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> store(Map<String, dynamic> data) async {
    try {
      final Response response = await httpClient.post(
        'sickLeaves',
        data: FormData.fromMap(data),
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );
      print(prettyJson(response.data));

      if (response.statusCode == 422) {
        print(prettyJson(response.data['errors']));
        return SickleaveFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      return Sickleave.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
