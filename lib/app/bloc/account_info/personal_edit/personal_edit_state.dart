part of 'personal_edit_bloc.dart';

abstract class PersonalEditState extends Equatable {
  const PersonalEditState();

  @override
  List<Object> get props => [];
}

class PersonalEditInitial extends PersonalEditState {}

class PersonalEditLoading extends PersonalEditState {}

class PersonalEditSuccess extends PersonalEditState {
  final PersonalModel data;
  const PersonalEditSuccess({@required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'PersonalEditSuccess { data: $data }';
}

class PersonalEditInvalid extends PersonalEditState {
  final PersonalEditValidationException exception;
  const PersonalEditInvalid({@required this.exception});

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'PersonalEditInvalid { exception: $exception }';
}

class PersonalEditFailure extends PersonalEditState {
  final String error;
  const PersonalEditFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PersonalEditFailure { error: $error }';
}
