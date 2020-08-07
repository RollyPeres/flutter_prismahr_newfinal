part of 'experience_create_bloc.dart';

abstract class ExperienceCreateState extends Equatable {
  const ExperienceCreateState();

  @override
  List<Object> get props => [];
}

class ExperienceCreateInitial extends ExperienceCreateState {}

class ExperienceCreateLoading extends ExperienceCreateState {}

class ExperienceCreateSuccess extends ExperienceCreateState {
  final Experience data;
  const ExperienceCreateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ExperienceCreateSuccess { data: $data }';
}

class ExperienceCreateInvalid extends ExperienceCreateState {
  final ExperienceFormValidationException exception;
  const ExperienceCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'ExperienceCreateInvalid { exception: $exception }';
}

class ExperienceCreateFailure extends ExperienceCreateState {
  final String error;
  const ExperienceCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ExperienceCreateFailure { error: $error }';
}
