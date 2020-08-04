class EducationFormValidationException {
  List id;
  List userId;
  List institution;
  List graduationMonth;
  List graduationYear;
  List qualification;
  List location;
  List fieldOfStudy;
  List majors;
  List finalScore;
  List additionalInfo;

  EducationFormValidationException({
    id,
    userId,
    institution,
    graduationMonth,
    graduationYear,
    qualification,
    location,
    fieldOfStudy,
    majors,
    finalScore,
    additionalInfo,
  });

  EducationFormValidationException.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.userId = json['user_id'];
    this.institution = json['institution'];
    this.graduationMonth = json['graduation_month'];
    this.graduationYear = json['graduation_year'];
    this.qualification = json['qualification'];
    this.location = json['location'];
    this.fieldOfStudy = json['field_of_study'];
    this.majors = json['majors'];
    this.finalScore = json['final_score'];
    this.additionalInfo = json['additional_info'];
  }
}
