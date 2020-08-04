import 'package:flutter_prismahr/app/data/providers/account_info/education_provider.dart';

import 'package:meta/meta.dart';

class EducationRepository {
  final EducationProvider provider;

  const EducationRepository({@required this.provider})
      : assert(provider != null);

  Future fetch() {
    return provider.fetch();
  }

  Future add(Map<String, dynamic> data) {
    return provider.store(data);
  }
}
