part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventEmpty extends EventState {}

class EventLoaded extends EventState {
  final List<Event> data;
  const EventLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'EventLoaded { data: $data }';
}

class EventFailure extends EventState {
  final String error;
  const EventFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EventFailure { error: $error }';
}

class EventCreated extends EventState {
  final Event data;
  const EventCreated({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'EventCreated { data: $data }';
}
