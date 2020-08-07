part of 'experience_create_bloc.dart';

abstract class ExperienceCreateEvent extends Equatable {
  const ExperienceCreateEvent();
}

class ExperienceCreateSubmitButtonPressed extends ExperienceCreateEvent {
  final String company;
  final String position;
  final String periodStartYear;
  final String periodStartMonth;
  final String periodEndYear;
  final String periodEndMonth;
  final String present;
  final String specialization;
  final String workfield;
  final String country;
  final String industry;
  final String role;
  final String salaryCurrency;
  final String salary;
  final String description;

  const ExperienceCreateSubmitButtonPressed({
    @required this.company,
    @required this.position,
    @required this.periodStartYear,
    @required this.periodStartMonth,
    @required this.periodEndYear,
    @required this.periodEndMonth,
    @required this.present,
    @required this.specialization,
    @required this.workfield,
    @required this.country,
    @required this.industry,
    @required this.role,
    @required this.salaryCurrency,
    @required this.salary,
    @required this.description,
  });

  @override
  List<Object> get props => [
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
      ];

  @override
  String toString() => 'ExperienceCreateSubmitButtonPressed '
      '{'
      ' company: $company,'
      ' position: $position,'
      ' period_start_year: $periodStartYear,'
      ' period_start_month: $periodStartMonth,'
      ' period_end_year: $periodEndYear,'
      ' period_end_month: $periodEndMonth,'
      ' present: $present,'
      ' specialization: $specialization,'
      ' workfield: $workfield,'
      ' country: $country,'
      ' industry: $industry,'
      ' role: $role,'
      ' salaryCurrency: $salaryCurrency,'
      ' salary: $salary,'
      ' description: $description, '
      '}';
}
