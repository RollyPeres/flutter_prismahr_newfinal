part of 'sickleave_create_bloc.dart';

abstract class SickleaveCreateState extends Equatable {
  const SickleaveCreateState();

  @override
  List<Object> get props => [];
}

class SickleaveCreateInitial extends SickleaveCreateState {}

class SickleaveCreateLoading extends SickleaveCreateState {}

class SickleaveCreateSuccess extends SickleaveCreateState {
  final Sickleave data;
  const SickleaveCreateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'SickleaveCreateSuccess { data: $data }';
}

class SickleaveCreateInvalid extends SickleaveCreateState {
  final SickleaveFormValidationException exception;
  const SickleaveCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'SickleaveCreateInvalid { exception: $exception }';
}

class SickleaveCreateFailure extends SickleaveCreateState {
  final String error;
  const SickleaveCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SickleaveCreateFailure { error: $error }';
}
