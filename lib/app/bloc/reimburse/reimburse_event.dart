part of 'reimburse_bloc.dart';

abstract class ReimburseEvent extends Equatable {
  const ReimburseEvent();

  @override
  List<Object> get props => [];
}

class ReimburseScreenInitialized extends ReimburseEvent {}

class ReimburseAdded extends ReimburseEvent {
  final Reimburse data;
  const ReimburseAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ReimburseAdded { data: $data }';
}
