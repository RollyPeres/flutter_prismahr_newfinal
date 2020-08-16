import 'dart:convert';

import 'package:flutter_prismahr/app/data/models/image_model.dart';
import 'package:flutter_prismahr/app/data/models/user_model.dart';

class Sickleave {
  int id;
  String reason;
  String details;
  String startDate;
  String endDate;
  List<ImageModel> receipts;
  String approvedAt;
  String rejectedAt;
  User approver;
  User rejector;
  String createdAt;
  String updatedAt;
  User applicant;

  Sickleave({
    id,
    reason,
    details,
    startDate,
    endDate,
    receipts,
    approvedAt,
    rejectedAt,
    approver,
    rejector,
    createdAt,
    updatedAt,
    applicant,
  });

  Sickleave.fromJson(Map<String, dynamic> json) {
    User approver = User();
    User rejector = User();
    User applicant = User();

    List rawReceipts = jsonDecode(json['receipts']) as List;
    List<ImageModel> receipts =
        rawReceipts.map((r) => ImageModel.fromJson(r)).toList();

    if (json['approver'] != null) {
      approver = User.fromJson(json['approver']);
    }

    if (json['rejector'] != null) {
      rejector = User.fromJson(json['rejector']);
    }

    if (json['applicant'] != null) {
      applicant = User.fromJson(json['applicant']);
    }

    this.id = json['id'];
    this.reason = json['reason'];
    this.details = json['details'];
    this.startDate = json['start_date'];
    this.endDate = json['end_date'];
    this.receipts = receipts;
    this.approvedAt = json['approved_at'];
    this.rejectedAt = json['rejected_at'];
    this.approver = approver;
    this.rejector = rejector;
    this.createdAt = json['created_at'];
    this.updatedAt = json['updated_at'];
    this.applicant = applicant;
  }
}
