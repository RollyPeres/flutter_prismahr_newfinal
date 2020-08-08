import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class ContactProvider {
  final Dio httpClient = Request.dio;

  Future<List<Contact>> fetch() async {
    try {
      final Response response = await httpClient.get('user/contactInfo');
      final List list = response.data['data'] as List;
      return list.map((contact) => Contact.fromJson(contact)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> add(Map<String, dynamic> data) async {
    try {
      final Response response =
          await httpClient.post('user/contactInfo', data: data);

      if (response.statusCode == 422) {
        return ContactFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      return Contact.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
