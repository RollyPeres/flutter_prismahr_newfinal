part of 'personal_bloc.dart';

abstract class PersonalEvent extends Equatable {
  const PersonalEvent();

  @override
  List<Object> get props => [];
}

class PersonalScreenInitialized extends PersonalEvent {}

class PersonalDataUpdated extends PersonalEvent {
  final PersonalModel data;
  const PersonalDataUpdated({@required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'PersonalDataUpdated { data: $data }';
}
