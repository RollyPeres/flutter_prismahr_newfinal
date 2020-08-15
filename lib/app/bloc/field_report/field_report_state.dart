part of 'field_report_bloc.dart';

abstract class FieldReportState extends Equatable {
  const FieldReportState();

  @override
  List<Object> get props => [];
}

class FieldReportInitial extends FieldReportState {}

class FieldReportLoading extends FieldReportState {}

class FieldReportEmpty extends FieldReportState {}

class FieldReportLoaded extends FieldReportState {
  final List<FieldReport> data;
  const FieldReportLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'FieldReportLoaded { data: $data }';
}

class FieldReportFailure extends FieldReportState {
  final String error;
  const FieldReportFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FieldReportFailure { error: $error }';
}

class FieldReportCreated extends FieldReportState {
  final FieldReport data;
  const FieldReportCreated({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'FieldReportCreated { data: $data }';
}

class FieldReportDeleted extends FieldReportState {
  final FieldReport data;
  const FieldReportDeleted({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'FieldReportDeleted { data: $data }';
}
