part of 'education_create_bloc.dart';

abstract class EducationCreateEvent extends Equatable {
  const EducationCreateEvent();
}

class EducationCreateSubmitButtonPressed extends EducationCreateEvent {
  final String institution;
  final String graduationMonth;
  final String graduationYear;
  final String qualification;
  final String location;
  final String fieldOfStudy;
  final String majors;
  final String finalScore;
  final String additionalInfo;

  const EducationCreateSubmitButtonPressed({
    @required this.institution,
    @required this.graduationMonth,
    @required this.graduationYear,
    @required this.qualification,
    @required this.location,
    @required this.fieldOfStudy,
    @required this.majors,
    @required this.finalScore,
    @required this.additionalInfo,
  });

  @override
  List<Object> get props => [
        institution,
        graduationMonth,
        graduationYear,
        qualification,
        location,
        fieldOfStudy,
        majors,
        finalScore,
        additionalInfo,
      ];

  @override
  String toString() => 'EducationCreateSubmitButtonPressed '
      '{'
      ' institution: $institution,'
      ' graduation_month: $graduationMonth,'
      ' graduation_year: $graduationYear,'
      ' qualification: $qualification,'
      ' location: $location,'
      ' field_of_study: $fieldOfStudy,'
      ' majors: $majors,'
      ' final_score: $finalScore,'
      ' additional_info: $additionalInfo, '
      '}';
}
