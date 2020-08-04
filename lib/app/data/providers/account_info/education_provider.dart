import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/account_info/education_form_validation_exception_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/account_info/education_model.dart';

class EducationProvider {
  final Dio httpClient;

  EducationProvider({@required this.httpClient}) : assert(httpClient != null);

  Future fetch() async {
    await Future.delayed(Duration(seconds: 5));
    try {
      final Response response = await httpClient.get('user/educationInfo');

      if (response.data['data'] == null) {
        return EducationModel();
      }

      final List listEducations = response.data['data'] as List;
      final List<EducationModel> educations =
          listEducations.map((e) => EducationModel.fromJson(e)).toList();

      return educations;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future store(Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 5));
    try {
      final Response response =
          await httpClient.post('user/educationInfo', data: data);

      if (response.statusCode == 422) {
        return EducationFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      return EducationModel.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
