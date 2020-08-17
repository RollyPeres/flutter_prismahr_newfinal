import 'dart:convert';

import 'package:flutter_prismahr/app/data/models/image_model.dart';
import 'package:flutter_prismahr/app/data/models/reimburse_type_model.dart';
import 'package:flutter_prismahr/app/data/models/user_model.dart';

class Reimburse {
  int id;
  ReimburseType type;
  String reason;
  String date;
  int nominal;
  String details;
  List<ImageModel> receipts;
  String approvedAt;
  String rejectedAt;
  String createdAt;
  String updatedAt;
  User approver;
  User rejector;
  User applicant;

  Reimburse({
    id,
    type,
    reason,
    date,
    nominal,
    details,
    receipts,
    approvedAt,
    rejectedAt,
    createdAt,
    updatedAt,
    approver,
    rejector,
    applicant,
  });

  Reimburse.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.reason = json['reason'];
    this.date = json['date'];
    this.details = json['details'];
    this.approvedAt = json['approved_at'];
    this.rejectedAt = json['rejected_at'];
    this.createdAt = json['created_at'];
    this.updatedAt = json['updated_at'];

    if (json['nominal'] is String) {
      this.nominal = int.parse(json['nominal']);
    } else {
      this.nominal = json['nominal'];
    }

    if (json['receipts'] != null) {
      final List rawReceipts = jsonDecode(json['receipts']) as List;
      final List<ImageModel> receipts =
          rawReceipts.map((r) => ImageModel.fromJson(r)).toList();

      this.receipts = receipts;
    }

    if (json['type'] != null) {
      this.type = ReimburseType.fromJson(json['type']);
    }

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

class ReimburseFormValidationException {
  List reason;
  List date;
  List nominal;
  List details;
  List receipts;

  ReimburseFormValidationException({
    reason,
    date,
    nominal,
    details,
    receipts,
  });

  ReimburseFormValidationException.fromJson(Map<String, dynamic> json) {
    this.reason = json['reason'];
    this.date = json['date'];
    this.nominal = json['nominal'];
    this.nominal = json['nominal'];
    this.details = json['details'];
    this.receipts = json['receipts'];
  }
}
