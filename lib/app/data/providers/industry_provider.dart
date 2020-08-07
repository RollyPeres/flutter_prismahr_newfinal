import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/industry_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class IndustryProvider {
  final Dio httpClient = Request.dio;

  Future<List<Industry>> find(String name) async {
    try {
      final Response response = await httpClient.get('industries');
      final List list = response.data['data'] as List;

      final List<Industry> industries =
          list.map((industry) => Industry.fromJson(industry)).toList();

      return industries;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
