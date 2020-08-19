import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class LoanTenorProvider {
  final Dio httpClient = Request.dio;

  Future<List<LoanTenor>> fetch() async {
    try {
      final Response response = await httpClient.get('loanTenors');
      final List list = response.data['data'] as List;

      if (response.data['data'] == null) {
        return const <LoanTenor>[];
      }

      return list.map((l) => LoanTenor.fromJson(l)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
