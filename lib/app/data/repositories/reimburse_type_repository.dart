import 'package:flutter_prismahr/app/data/models/reimburse_type_model.dart';
import 'package:flutter_prismahr/app/data/providers/reimburse_type_provider.dart';

class ReimburseTypeRepository {
  final ReimburseTypeProvider provider = ReimburseTypeProvider();

  Future<List<ReimburseType>> find(String name) {
    return provider.find(name);
  }
}
