part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class ContactScreenInitialized extends ContactEvent {}

class ContactAdded extends ContactEvent {
  final Contact data;
  const ContactAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ContactAdded { data: $data }';
}
