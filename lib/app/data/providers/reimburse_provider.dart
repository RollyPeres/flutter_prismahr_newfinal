import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/reimburse_model.dart';
import 'package:flutter_prismahr/utils/request.dart';
import 'package:pretty_json/pretty_json.dart';

class ReimburseProvider {
  final Dio httpClient = Request.dio;

  Future<List<Reimburse>> fetch() async {
    try {
      final Response response = await httpClient.get('reimburses');
      final List list = response.data['data'] as List;

      if (response.data['data'] == null) {
        return const <Reimburse>[];
      }

      print(prettyJson(response.data['data'][0]));

      return list.map((l) => Reimburse.fromJson(l)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> store(Map<String, dynamic> data) async {
    try {
      final Response response = await httpClient.post(
        'reimburses',
        data: FormData.fromMap(data),
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );

      if (response.statusCode == 422) {
        return ReimburseFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      print(prettyJson(response.data['data']));
      return Reimburse.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
