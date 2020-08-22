part of 'leave_update_bloc.dart';

abstract class LeaveUpdateState extends Equatable {
  const LeaveUpdateState();

  @override
  List<Object> get props => [];
}

class LeaveUpdateInitial extends LeaveUpdateState {}

class LeaveUpdateLoading extends LeaveUpdateState {}

class LeaveUpdateSuccess extends LeaveUpdateState {
  final Leave data;
  const LeaveUpdateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LeaveUpdateSuccess { data: $data }';
}

class LeaveUpdateInvalid extends LeaveUpdateState {
  final LeaveFormValidationException exception;
  const LeaveUpdateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'LeaveUpdateInvalid { exception: $exception }';
}

class LeaveUpdateFailure extends LeaveUpdateState {
  final String error;
  const LeaveUpdateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LeaveUpdateFailure { error: $error }';
}
