part of 'field_report_update_bloc.dart';

abstract class FieldReportUpdateState extends Equatable {
  const FieldReportUpdateState();

  @override
  List<Object> get props => [];
}

class FieldReportUpdateInitial extends FieldReportUpdateState {}

class FieldReportUpdateLoading extends FieldReportUpdateState {}

class FieldReportUpdateSuccess extends FieldReportUpdateState {
  final FieldReport data;
  const FieldReportUpdateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'FieldReportUpdateSuccess { data: $data }';
}

class FieldReportUpdateInvalid extends FieldReportUpdateState {
  final FieldReportFormValidationException exception;
  const FieldReportUpdateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'FieldReportUpdateInvalid { exception: $exception }';
}

class FieldReportUpdateFailure extends FieldReportUpdateState {
  final String error;
  const FieldReportUpdateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FieldReportUpdateFailure { error: $error }';
}
