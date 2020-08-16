part of 'leave_create_bloc.dart';

abstract class LeaveCreateState extends Equatable {
  const LeaveCreateState();

  @override
  List<Object> get props => [];
}

class LeaveCreateInitial extends LeaveCreateState {}

class LeaveCreateLoading extends LeaveCreateState {}

class LeaveCreateSuccess extends LeaveCreateState {
  final Leave data;
  const LeaveCreateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LeaveCreateSuccess { data: $data }';
}

class LeaveCreateInvalid extends LeaveCreateState {
  final LeaveFormValidationException exception;
  const LeaveCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'LeaveCreateInvalid { exception: $exception }';
}

class LeaveCreateFailure extends LeaveCreateState {
  final String error;
  const LeaveCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LeaveCreateFailure { error: $error }';
}
