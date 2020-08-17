import 'package:flutter_prismahr/app/data/models/reimburse_model.dart';
import 'package:flutter_prismahr/app/data/providers/reimburse_provider.dart';

class ReimburseRepository {
  final ReimburseProvider provider = ReimburseProvider();

  Future<List<Reimburse>> fetch() {
    return provider.fetch();
  }

  Future<dynamic> add(Map<String, dynamic> data) {
    return provider.store(data);
  }
}
