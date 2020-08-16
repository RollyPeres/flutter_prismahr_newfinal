class SickleaveFormValidationException {
  List reason;
  List details;
  List startDate;
  List endDate;
  List receipts;

  SickleaveFormValidationException({
    reason,
    details,
    startDate,
    endDate,
    receipts,
  });

  SickleaveFormValidationException.fromJson(Map<String, dynamic> json) {
    this.reason = json['reason'];
    this.details = json['details'];
    this.startDate = json['start_date'];
    this.endDate = json['end_date'];
    this.receipts = json['receipts'];
  }
}
