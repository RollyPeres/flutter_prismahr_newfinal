part of 'experience_bloc.dart';

abstract class ExperienceEvent extends Equatable {
  const ExperienceEvent();

  @override
  List<Object> get props => [];
}

class ExperienceScreenInitialized extends ExperienceEvent {}

class ExperienceAdded extends ExperienceEvent {
  final Experience data;
  const ExperienceAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ExperienceAdded { data: $data }';
}
