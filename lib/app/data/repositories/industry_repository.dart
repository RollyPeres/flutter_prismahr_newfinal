import 'package:flutter_prismahr/app/data/models/industry_model.dart';
import 'package:flutter_prismahr/app/data/providers/industry_provider.dart';

class IndustryRepository {
  final IndustryProvider provider = IndustryProvider();

  Future<List<Industry>> find(String name) {
    return provider.find(name);
  }
}
