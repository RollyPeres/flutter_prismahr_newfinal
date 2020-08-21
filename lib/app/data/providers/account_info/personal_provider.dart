import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_edit_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_model.dart';
import 'package:meta/meta.dart';

class PersonalProvider {
  final Dio httpClient;

  PersonalProvider({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future fetch() async {
    try {
      final Response response = await httpClient.get('user/personalInfo');

      if (response.data['data'] == null) {
        return PersonalModel();
      }

      return PersonalModel.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future update(Map<String, dynamic> data) async {
    try {
      final Response response =
          await httpClient.post('user/personalInfo', data: data);

      if (response.statusCode == 422) {
        return PersonalEditValidationException.fromJson(
          response.data['errors'],
        );
      }

      return PersonalModel.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
