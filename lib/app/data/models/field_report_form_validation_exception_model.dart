class FieldReportFormValidationException {
  List title;
  List chronology;
  // ? TODO: Furukawa, don't we need image validation here?

  FieldReportFormValidationException({title, chronology});

  FieldReportFormValidationException.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.chronology = json['chronology'];
  }
}
