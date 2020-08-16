part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  List<Object> get props => [];
}

class LeaveScreenInitialized extends LeaveEvent {}

class LeaveAdded extends LeaveEvent {
  final Leave data;
  const LeaveAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LeaveAdded { data: $data }';
}
