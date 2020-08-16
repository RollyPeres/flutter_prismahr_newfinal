import 'package:flutter_prismahr/app/data/models/sickleave_model.dart';
import 'package:flutter_prismahr/app/data/providers/sickleave_provider.dart';

class SickleaveRepository {
  final SickleaveProvider provider = SickleaveProvider();

  Future<List<Sickleave>> fetch() {
    return provider.fetch();
  }

  Future<dynamic> add(Map<String, dynamic> data) {
    return provider.store(data);
  }
}
