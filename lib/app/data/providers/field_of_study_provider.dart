import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/field_of_study_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class FieldOfStudyProvider {
  final Dio httpClient = Request.dio;

  Future<List<FieldOfStudy>> find(String name) async {
    try {
      final Response response =
          await httpClient.get('studies', queryParameters: {'name': name});

      final List list = response.data['data'] as List;
      final List<FieldOfStudy> studies =
          list.map((f) => FieldOfStudy.fromJson(f)).toList();

      return studies;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
