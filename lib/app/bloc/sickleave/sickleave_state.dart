part of 'sickleave_bloc.dart';

abstract class SickleaveState extends Equatable {
  const SickleaveState();

  @override
  List<Object> get props => [];
}

class SickleaveInitial extends SickleaveState {}

class SickleaveLoading extends SickleaveState {}

class SickleaveEmpty extends SickleaveState {}

class SickleaveLoaded extends SickleaveState {
  final List<Sickleave> data;
  const SickleaveLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'SickleaveLoaded { data: $data }';
}

class SickleaveFailure extends SickleaveState {
  final String error;
  const SickleaveFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SickleaveFailure { error: $error }';
}

class SickleaveCreated extends SickleaveState {
  final Sickleave data;
  const SickleaveCreated({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'SickleaveCreated { data: $data }';
}
