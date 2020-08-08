part of 'contact_create_bloc.dart';

abstract class ContactCreateEvent extends Equatable {
  const ContactCreateEvent();
}

class ContactCreateSubmitButtonPressed extends ContactCreateEvent {
  final String relation;
  final String name;
  final String phone;
  final String phoneAlt;

  const ContactCreateSubmitButtonPressed({
    @required this.relation,
    @required this.name,
    @required this.phone,
    @required this.phoneAlt,
  });

  @override
  List<Object> get props => [
        relation,
        name,
        phone,
        phoneAlt,
      ];

  @override
  String toString() => 'ContactCreateSubmitButtonPressed '
      '{'
      ' relation: $relation,'
      ' name: $name,'
      ' phone: $phone,'
      ' phone_alt: $phoneAlt, '
      '}';
}
