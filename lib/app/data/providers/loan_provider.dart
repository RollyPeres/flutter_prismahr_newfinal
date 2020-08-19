import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class LoanProvider {
  final Dio httpClient = Request.dio;

  Future<List<Loan>> fetch() async {
    try {
      final Response response = await httpClient.get('loans');
      final List list = response.data['data'] as List;

      if (response.data['data'] == null) {
        return const <Loan>[];
      }

      return list.map((l) => Loan.fromJson(l)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> store(Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 5));
    try {
      final Response response = await httpClient.post(
        'loans',
        data: FormData.fromMap(data),
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );

      if (response.statusCode == 422) {
        return LoanFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      return Loan.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
