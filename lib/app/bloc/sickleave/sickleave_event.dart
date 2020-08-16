part of 'sickleave_bloc.dart';

abstract class SickleaveEvent extends Equatable {
  const SickleaveEvent();

  @override
  List<Object> get props => [];
}

class SickleaveScreenInitialized extends SickleaveEvent {}

class SickleaveAdded extends SickleaveEvent {
  final Sickleave data;
  const SickleaveAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'SickleaveAdded { data: $data }';
}
