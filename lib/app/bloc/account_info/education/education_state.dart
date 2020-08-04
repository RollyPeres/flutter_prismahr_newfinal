part of 'education_bloc.dart';

abstract class EducationState extends Equatable {
  const EducationState();

  @override
  List<Object> get props => [];
}

class EducationInitial extends EducationState {}

class EducationLoading extends EducationState {}

class EducationLoaded extends EducationState {
  final List<EducationModel> data;
  const EducationLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'EducationLoaded { data: $data }';
}

class EducationCreated extends EducationState {
  final EducationModel education;
  const EducationCreated({@required this.education})
      : assert(education != null);

  @override
  List<Object> get props => [education];

  @override
  String toString() => 'EducationCreated { education: $education }';
}

class EducationEmpty extends EducationState {}

class EducationFailure extends EducationState {
  final String error;
  const EducationFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EducationFailure { error: $error }';
}
