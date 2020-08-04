part of 'education_create_bloc.dart';

abstract class EducationCreateState extends Equatable {
  const EducationCreateState();

  @override
  List<Object> get props => [];
}

class EducationCreateInitial extends EducationCreateState {}

class EducationCreateLoading extends EducationCreateState {}

class EducationCreateSuccess extends EducationCreateState {
  final EducationModel data;
  const EducationCreateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'EducationCreateSuccess { data: $data }';
}

class EducationCreateInvalid extends EducationCreateState {
  final EducationFormValidationException exception;
  const EducationCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'EducationCreateInvalid { exception: $exception }';
}

class EducationCreateFailure extends EducationCreateState {
  final String error;
  const EducationCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EducationCreateFailure { error: $error }';
}
