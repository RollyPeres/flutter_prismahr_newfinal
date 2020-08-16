part of 'leave_bloc.dart';

abstract class LeaveState extends Equatable {
  const LeaveState();

  @override
  List<Object> get props => [];
}

class LeaveInitial extends LeaveState {}

class LeaveLoading extends LeaveState {}

class LeaveEmpty extends LeaveState {}

class LeaveLoaded extends LeaveState {
  final List<Leave> data;
  const LeaveLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LeaveLoaded { data: $data }';
}

class LeaveFailure extends LeaveState {
  final String error;
  const LeaveFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LeaveFailure { error: $error }';
}

class LeaveCreated extends LeaveState {
  final Leave data;
  const LeaveCreated({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LeaveCreated { data: $data }';
}
