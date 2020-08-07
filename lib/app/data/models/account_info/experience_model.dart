class Experience {
  String company;
  String position;
  int periodStartYear;
  int periodStartMonth;
  int periodEndYear;
  int periodEndMonth;
  int present;
  String specialization;
  String workfield;
  String country;
  String industry;
  String role;
  String salaryCurrency;
  int salary;
  String description;

  Experience({
    company,
    position,
    periodStartYear,
    periodStartMonth,
    periodEndYear,
    periodEndMonth,
    present,
    specialization,
    workfield,
    country,
    industry,
    role,
    salaryCurrency,
    salary,
    description,
  });

  Experience.fromJson(Map<String, dynamic> json) {
    this.company = json['company'];
    this.position = json['position'];
    this.periodStartYear = json['period_start_year'];
    this.periodStartMonth = json['period_start_month'];
    this.periodEndYear = json['period_end_year'];
    this.periodEndMonth = json['period_end_month'];
    this.present = json['present'];
    this.specialization = json['specialization'];
    this.workfield = json['workfield'];
    this.country = json['country'];
    this.industry = json['industry'];
    this.role = json['role'];
    this.salaryCurrency = json['salary_currency'];
    this.salary = json['salary'];
    this.description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = Map<String, dynamic>();
    json['company'] = this.company;
    json['position'] = this.position;
    json['period_start_year'] = this.periodStartYear;
    json['period_start_month'] = this.periodStartMonth;
    json['period_end_year'] = this.periodEndYear;
    json['period_end_month'] = this.periodEndMonth;
    json['present'] = this.present;
    json['specialization'] = this.specialization;
    json['workfield'] = this.workfield;
    json['country'] = this.country;
    json['industry'] = this.industry;
    json['role'] = this.role;
    json['salary_currency'] = this.salaryCurrency;
    json['salary'] = this.salary;
    json['description'] = this.description;
    return json;
  }
}
