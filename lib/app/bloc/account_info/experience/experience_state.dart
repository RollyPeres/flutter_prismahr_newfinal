part of 'experience_bloc.dart';

abstract class ExperienceState extends Equatable {
  const ExperienceState();

  @override
  List<Object> get props => [];
}

class ExperienceInitial extends ExperienceState {}

class ExperienceLoading extends ExperienceState {}

class ExperienceEmpty extends ExperienceState {}

class ExperienceLoaded extends ExperienceState {
  final List<Experience> data;
  const ExperienceLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ExperienceLoaded { data: $data }';
}

class ExperienceFailure extends ExperienceState {
  final String error;
  const ExperienceFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ExperienceFailure { error: $error }';
}

class ExperienceCreated extends ExperienceState {
  final Experience data;
  const ExperienceCreated({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ExperienceCreated { data: $data }';
}
