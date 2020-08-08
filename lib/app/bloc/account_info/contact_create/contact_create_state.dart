part of 'contact_create_bloc.dart';

abstract class ContactCreateState extends Equatable {
  const ContactCreateState();

  @override
  List<Object> get props => [];
}

class ContactCreateInitial extends ContactCreateState {}

class ContactCreateLoading extends ContactCreateState {}

class ContactCreateSuccess extends ContactCreateState {
  final Contact data;
  const ContactCreateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ContactCreateSuccess { data: $data }';
}

class ContactCreateInvalid extends ContactCreateState {
  final ContactFormValidationException exception;
  const ContactCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'ContactCreateInvalid { exception: $exception }';
}

class ContactCreateFailure extends ContactCreateState {
  final String error;
  const ContactCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ContactCreateFailure { error: $error }';
}
