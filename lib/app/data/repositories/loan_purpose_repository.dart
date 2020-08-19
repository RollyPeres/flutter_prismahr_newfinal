import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/app/data/providers/loan_purpose_provider.dart';

class LoanPurposeRepository {
  final LoanPurposeProvider provider = LoanPurposeProvider();

  Future<List<LoanPurpose>> find(String name) {
    return provider.find(name);
  }
}
