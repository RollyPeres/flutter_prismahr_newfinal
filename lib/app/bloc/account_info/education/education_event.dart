part of 'education_bloc.dart';

abstract class EducationEvent extends Equatable {
  const EducationEvent();

  @override
  List<Object> get props => [];
}

class EducationScreenInitialized extends EducationEvent {}

class EducationAdded extends EducationEvent {
  final EducationModel data;
  const EducationAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'EducationAdded { data: $data }';
}

class EducationRemoved extends EducationEvent {
  final EducationModel data;
  const EducationRemoved({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'EducationRemoved { data: $data }';
}
