import 'package:flutter_prismahr/app/data/models/field_report_model.dart';
import 'package:flutter_prismahr/app/data/providers/field_report_provider.dart';

class FieldReportRepository {
  final FieldReportProvider provider = FieldReportProvider();

  Future<List<FieldReport>> fetch() {
    return provider.fetch();
  }

  Future<dynamic> add(Map<String, dynamic> data) {
    return provider.add(data);
  }

  Future<dynamic> update(int id, Map<String, dynamic> data) {
    return provider.update(id, data);
  }

  Future<dynamic> destroy(int id) {
    return provider.destroy(id);
  }
}
