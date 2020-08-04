import 'package:flutter_prismahr/app/data/models/field_of_study_model.dart';
import 'package:flutter_prismahr/app/data/providers/field_of_study_provider.dart';

class FieldOfStudyRepository {
  final FieldOfStudyProvider provider = FieldOfStudyProvider();

  Future<List<FieldOfStudy>> find(String name) {
    return provider.find(name);
  }
}
