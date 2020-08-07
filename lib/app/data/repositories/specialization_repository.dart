import 'package:flutter_prismahr/app/data/models/specialization_model.dart';
import 'package:flutter_prismahr/app/data/providers/specialization_provider.dart';

class SpecializationRepository {
  final SpecializationProvider provider = SpecializationProvider();

  Future<List<Specialization>> find(String name) {
    return provider.find(name);
  }
}
