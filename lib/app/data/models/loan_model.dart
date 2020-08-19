import 'package:flutter_prismahr/app/data/models/user_model.dart';

class Loan {
  int id;
  int nominal;
  LoanPurpose purpose;
  LoanTenor tenor;
  User applicant;
  User approver;
  User rejector;
  String createdAt;
  String updatedAt;
  String approvedAt;
  String rejectedAt;

  Loan({
    this.id,
    this.applicant,
    this.approver,
    this.rejector,
    this.purpose,
    this.tenor,
    this.nominal,
    this.createdAt,
    this.updatedAt,
    this.approvedAt,
    this.rejectedAt,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    if (json == null) return Loan();

    return Loan(
      id: json['id'],
      nominal: json['nominal'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      approvedAt: json['approved_at'],
      rejectedAt: json['rejected_at'],
      purpose: LoanPurpose.fromJson(json['purpose']),
      tenor: LoanTenor.fromJson(json['tenor']),
      applicant: User.fromJson(json['applicant']),
      approver: User.fromJson(json['approver']),
      rejector: User.fromJson(json['rejector']),
    );
  }
}

class LoanFormValidationException {
  List nominal;
  List purpose;
  List tenor;

  LoanFormValidationException({
    this.nominal,
    this.purpose,
    this.tenor,
  });

  factory LoanFormValidationException.fromJson(Map<String, dynamic> json) {
    if (json == null) return LoanFormValidationException();

    return LoanFormValidationException(
      nominal: json['nominal'],
      purpose: json['loan_purpose_id'],
      tenor: json['loan_tenor_id'],
    );
  }
}

class LoanTenor {
  int id;
  int tenor;
  int minProposedLoan;
  double interest;
  double adminFee;

  LoanTenor({
    this.id,
    this.tenor,
    this.minProposedLoan,
    this.interest,
    this.adminFee,
  });

  factory LoanTenor.fromJson(Map<String, dynamic> json) {
    if (json == null) return LoanTenor();

    return LoanTenor(
      id: json['id'],
      tenor: json['tenor'],
      minProposedLoan: json['min_proposed_loan'],
      interest: double.parse(json['interest']),
      adminFee: double.parse(json['admin_fee']),
    );
  }
}

class LoanPurpose {
  int id;
  String name;

  LoanPurpose({
    this.id,
    this.name,
  });

  factory LoanPurpose.fromJson(Map<String, dynamic> json) {
    if (json == null) return LoanPurpose();

    return LoanPurpose(
      id: json['id'],
      name: json['name'],
    );
  }
}
