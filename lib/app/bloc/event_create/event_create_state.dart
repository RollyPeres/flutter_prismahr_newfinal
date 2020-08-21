part of 'event_create_bloc.dart';

abstract class EventCreateState extends Equatable {
  const EventCreateState();

  @override
  List<Object> get props => [];
}

class EventCreateInitial extends EventCreateState {}

class EventCreateLoading extends EventCreateState {}

class EventCreateSuccess extends EventCreateState {
  final Event data;
  const EventCreateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'EventCreateSuccess { data: $data }';
}

class EventCreateInvalid extends EventCreateState {
  final EventFormValidationException exception;
  const EventCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'EventCreateInvalid { exception: $exception }';
}

class EventCreateFailure extends EventCreateState {
  final String error;
  const EventCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'EventCreateFailure { error: $error }';
}
