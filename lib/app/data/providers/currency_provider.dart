import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/currency_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class CurrencyProvider {
  final Dio httpClient = Request.dio;

  Future<List<Currency>> find(String name) async {
    try {
      final Response response =
          await httpClient.get('currencies', queryParameters: {'name': name});
      final List currencies = response.data['data'] as List;

      return currencies.map((c) => Currency.fromJson(c)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
