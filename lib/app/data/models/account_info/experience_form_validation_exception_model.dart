class ExperienceFormValidationException {
  List company;
  List position;
  List periodStartYear;
  List periodStartMonth;
  List periodEndYear;
  List periodEndMonth;
  List present;
  List specialization;
  List workfield;
  List country;
  List industry;
  List role;
  List salaryCurrency;
  List salary;
  List description;

  ExperienceFormValidationException({
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

  ExperienceFormValidationException.fromJson(Map<String, dynamic> json) {
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
}
