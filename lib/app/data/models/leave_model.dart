import 'package:flutter_prismahr/app/data/models/user_model.dart';

class Leave {
  int id;
  String reason;
  String startDate;
  String endDate;
  String details;
  String createdAt;
  String updatedAt;
  String approvedAt;
  String rejectedAt;
  User approver;
  User rejector;
  User applicant;

  Leave({
    id,
    reason,
    startDate,
    endDate,
    details,
    createdAt,
    updatedAt,
    approvedAt,
    rejectedAt,
    approver,
    rejector,
    applicant,
  });

  Leave.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.reason = json['reason'];
    this.startDate = json['start_date'];
    this.endDate = json['end_date'];
    this.details = json['details'];
    this.createdAt = json['created_at'];
    this.updatedAt = json['updated_at'];
    this.approvedAt = json['approved_at'];
    this.rejectedAt = json['rejected_at'];

    if (json['approver'] != null) {
      this.approver = User.fromJson(json['approver']);
    }

    if (json['rejector'] != null) {
      this.rejector = User.fromJson(json['rejector']);
    }

    if (json['applicant'] != null) {
      this.applicant = User.fromJson(json['applicant']);
    }
  }
}

class LeaveFormValidationException {
  List reason;
  List startDate;
  List endDate;
  List details;
  List approvedAt;
  List rejectedAt;

  LeaveFormValidationException({
    reason,
    startDate,
    endDate,
    details,
    approvedAt,
    rejectedAt,
  });

  LeaveFormValidationException.fromJson(Map<String, dynamic> json) {
    this.reason = json['reason'];
    this.startDate = json['start_date'];
    this.endDate = json['end_date'];
    this.details = json['details'];
    this.approvedAt = json['approved_at'];
    this.rejectedAt = json['rejected_at'];
  }
}
