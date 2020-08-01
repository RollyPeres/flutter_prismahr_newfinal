import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/providers/account_info/personal_provider.dart';

class PersonalRepository {
  final PersonalProvider provider;

  PersonalRepository({@required this.provider}) : assert(provider != null);

  Future fetch() {
    return provider.fetch();
  }

  Future update(Map<String, dynamic> data) {
    return provider.update(data);
  }
}
