import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class LoanPurposeProvider {
  final Dio httpClient = Request.dio;

  Future<List<LoanPurpose>> find(String name) async {
    try {
      final Response response = await httpClient.get(
        'loanPurposes',
        queryParameters: {'name': name},
      );

      final List list = response.data['data'] as List;
      if (response.data['data'] == null) {
        return const <LoanPurpose>[];
      }

      return list.map((l) => LoanPurpose.fromJson(l)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
