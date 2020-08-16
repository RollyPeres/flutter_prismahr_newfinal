import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/field_report_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/field_report_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class FieldReportProvider {
  final Dio httpClient = Request.dio;

  Future<List<FieldReport>> fetch() async {
    try {
      final Response response = await httpClient.get('fieldReports');
      final List list = response.data['data'] as List;

      return list.map((f) => FieldReport.fromJson(f)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> add(Map<String, dynamic> data) async {
    try {
      final Response response = await httpClient.post(
        'fieldReports',
        data: FormData.fromMap(data),
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );

      if (response.statusCode == 422) {
        return FieldReportFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      return FieldReport.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> update(int id, Map<String, dynamic> data) async {
    try {
      final Response response = await httpClient.patch(
        'fieldReports/$id',
        data: FormData.fromMap(data),
        options: Options(contentType: 'application/x-www-form-urlencoded'),
      );

      if (response.statusCode == 422) {
        return FieldReportFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      return FieldReport.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> destroy(int id) async {
    try {
      final Response response = await httpClient.delete('fieldReports/$id');
      return FieldReport.fromJson(response.data['deleted']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
