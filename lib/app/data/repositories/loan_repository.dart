import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/app/data/providers/loan_provider.dart';

class LoanRepository {
  final LoanProvider provider = LoanProvider();

  Future<List<Loan>> fetch() {
    return provider.fetch();
  }

  Future<dynamic> add(Map<String, dynamic> data) {
    return provider.store(data);
  }
}
