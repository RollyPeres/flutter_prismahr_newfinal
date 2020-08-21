part of 'event_create_bloc.dart';

abstract class EventCreateEvent extends Equatable {
  const EventCreateEvent();

  @override
  List<Object> get props => [];
}

class SubmitButtonPressed extends EventCreateEvent {
  final String name;
  final String date;
  final String details;
  final String location;
  final List<int> participants;

  const SubmitButtonPressed({
    @required this.name,
    @required this.date,
    @required this.details,
    @required this.location,
    @required this.participants,
  });

  @override
  List<Object> get props => [
        name,
        date,
        details,
        location,
        participants,
      ];

  @override
  String toString() => 'SubmitButtonPressed '
      '{'
      ' name: $name,'
      ' date: $date,'
      ' details: $details,'
      ' location: $location,'
      ' participants: $participants, '
      '}';
}
