import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class ExperienceProvider {
  final Dio httpClient = Request.dio;

  Future<List<Experience>> fetch() async {
    try {
      final Response response = await httpClient.get('user/workingExperiences');
      final List list = response.data['data'] as List;
      final List<Experience> experiences =
          list.map((e) => Experience.fromJson(e)).toList();
      return experiences;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future add(Map<String, dynamic> data) async {
    try {
      final Response response =
          await httpClient.post('user/workingExperiences', data: data);

      if (response.statusCode == 422) {
        return ExperienceFormValidationException.fromJson(
          response.data['data'],
        );
      }

      return Experience.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
