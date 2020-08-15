part of 'field_report_bloc.dart';

abstract class FieldReportEvent extends Equatable {
  const FieldReportEvent();

  @override
  List<Object> get props => [];
}

class FieldReportScreenInitialized extends FieldReportEvent {}

class FieldReportAdded extends FieldReportEvent {
  final FieldReport data;
  const FieldReportAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'FieldReportAdded { data: $data }';
}

class DeleteModalConfirmed extends FieldReportEvent {
  final int id;
  const DeleteModalConfirmed({@required this.id}) : assert(id != null);

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'DeleteModalConfirmed { id: $id }';
}
