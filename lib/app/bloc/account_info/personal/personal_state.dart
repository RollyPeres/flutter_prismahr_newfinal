part of 'personal_bloc.dart';

abstract class PersonalState extends Equatable {
  const PersonalState();

  @override
  List<Object> get props => [];
}

class PersonalInitial extends PersonalState {}

class PersonalLoading extends PersonalState {}

class PersonalLoaded extends PersonalState {
  final PersonalModel data;
  const PersonalLoaded({@required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'PersonalLoaded { data: $data }';
}

class PersonalFailure extends PersonalState {
  final String error;
  const PersonalFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'PersonalFailure { error: $error }';
}
