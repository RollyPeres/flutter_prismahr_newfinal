part of 'leave_bloc.dart';

abstract class LeaveEvent extends Equatable {
  const LeaveEvent();

  @override
  bool get stringify => true;
}

class LeaveScreenInitialized extends LeaveEvent {
  @override
  List<Object> get props => [];
}

class LeaveAdded extends LeaveEvent {
  final Leave data;
  const LeaveAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LeaveAdded { data: $data }';
}
