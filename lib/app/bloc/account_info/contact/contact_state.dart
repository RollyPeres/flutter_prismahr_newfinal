part of 'contact_bloc.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitial extends ContactState {}

class ContactLoading extends ContactState {}

class ContactEmpty extends ContactState {}

class ContactLoaded extends ContactState {
  final List<Contact> data;
  const ContactLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ContactLoaded { data: $data }';
}

class ContactFailure extends ContactState {
  final String error;
  const ContactFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ContactFailure { error: $error }';
}

class ContactCreated extends ContactState {
  final Contact data;
  const ContactCreated({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ContactCreated { data: $data }';
}
