import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/country_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class CountryProvider {
  final Dio httpClient = Request.dio;

  Future<List<Country>> find(String name) async {
    final Response response =
        await httpClient.get('countries', queryParameters: {'name': name});
    final List countries = response.data['data'] as List;

    return countries.map((c) => Country.fromJson(c)).toList();
  }
}
