import 'package:flutter_prismahr/app/data/models/event_model.dart';
import 'package:flutter_prismahr/app/data/providers/event_provider.dart';

class EventRepository {
  final EventProvider provider = EventProvider();

  Future<List<Event>> fetch() {
    return provider.fetch();
  }

  Future<dynamic> add(Map<String, dynamic> data) {
    return provider.store(data);
  }
}
