import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/event_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/event_model.dart';
import 'package:flutter_prismahr/utils/request.dart';

class EventProvider {
  final Dio httpClient = Request.dio;

  Future<List<Event>> fetch() async {
    try {
      final Response response = await httpClient.get('events');
      final List list = response.data['data'] as List;

      if (response.data['data'] == null) {
        return const <Event>[];
      }

      return list.map((l) => Event.fromJson(l)).toList();
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<dynamic> store(Map<String, dynamic> data) async {
    try {
      final Response response = await httpClient.post('events', data: data);

      if (response.statusCode == 422) {
        return EventFormValidationException.fromJson(
          response.data['errors'],
        );
      }

      return Event.fromJson(response.data['data']);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
