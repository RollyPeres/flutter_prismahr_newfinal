import 'package:flutter_prismahr/app/data/models/account_info/experience_model.dart';
import 'package:flutter_prismahr/app/data/providers/account_info/experience_provider.dart';

class ExperienceRepository {
  final ExperienceProvider provider = ExperienceProvider();

  Future<List<Experience>> fetch() {
    return provider.fetch();
  }

  Future<dynamic> add(Map<String, dynamic> data) {
    return provider.add(data);
  }
}
