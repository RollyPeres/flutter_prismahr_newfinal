part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventScreenInitialized extends EventEvent {}

class EventAdded extends EventEvent {
  final Event data;
  const EventAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'EventAdded { data: $data }';
}
