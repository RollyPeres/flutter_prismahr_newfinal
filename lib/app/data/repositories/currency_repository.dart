import 'package:flutter_prismahr/app/data/models/currency_model.dart';
import 'package:flutter_prismahr/app/data/providers/currency_provider.dart';

class CurrencyRepository {
  final CurrencyProvider provider = CurrencyProvider();

  Future<List<Currency>> find(String name) {
    return provider.find(name);
  }
}
