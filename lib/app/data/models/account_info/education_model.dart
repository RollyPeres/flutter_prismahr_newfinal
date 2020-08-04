class EducationModel {
  int id;
  int userId;
  String institution;
  int graduationMonth;
  int graduationYear;
  String qualification;
  String location;
  String fieldOfStudy;
  String majors;
  String finalScore;
  String additionalInfo;

  EducationModel({
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

  EducationModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['institution'] = this.institution;
    data['graduation_month'] = this.graduationMonth;
    data['graduation_year'] = this.graduationYear;
    data['qualification'] = this.qualification;
    data['location'] = this.location;
    data['field_of_study'] = this.fieldOfStudy;
    data['majors'] = this.majors;
    data['final_score'] = this.finalScore;
    data['additional_info'] = this.additionalInfo;
    return data;
  }
}
