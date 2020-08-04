import 'package:flutter_prismahr/app/data/models/country_model.dart';
import 'package:flutter_prismahr/app/data/providers/country_provider.dart';

class CountryRepository {
  final CountryProvider provider = CountryProvider();

  Future<List<Country>> find(String country) {
    return provider.find(country);
  }
}
