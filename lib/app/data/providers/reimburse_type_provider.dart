import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/reimburse_type_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class ReimburseTypeProvider {
  final Dio httpClient = Request.dio;

  Future<List<ReimburseType>> find(String name) async {
    try {
      final Response response = await httpClient.get(
        'reimburseTypes',
        queryParameters: {'name': name},
      );

      if (response.data['data'] == null) {
        return const <ReimburseType>[];
      }

      final List list = response.data['data'] as List;
      return list.map((rt) => ReimburseType.fromJson(rt)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
