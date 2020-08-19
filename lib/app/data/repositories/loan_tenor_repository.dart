import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/app/data/providers/loan_tenor_provider.dart';

class LoanTenorRepository {
  final LoanTenorProvider provider = LoanTenorProvider();

  Future<List<LoanTenor>> fetch() {
    return provider.fetch();
  }
}
