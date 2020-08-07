import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/specialization_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class SpecializationProvider {
  final Dio httpClient = Request.dio;

  Future<List<Specialization>> find(String name) async {
    try {
      final Response response = await httpClient.get('specializations');
      final List list = response.data['data'] as List;

      final List<Specialization> specializations = list
          .map((specialization) => Specialization.fromJson(specialization))
          .toList();

      return specializations;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
