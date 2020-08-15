part of 'field_report_create_bloc.dart';

abstract class FieldReportCreateState extends Equatable {
  const FieldReportCreateState();

  @override
  List<Object> get props => [];
}

class FieldReportCreateInitial extends FieldReportCreateState {}

class FieldReportCreateLoading extends FieldReportCreateState {}

class FieldReportCreateSuccess extends FieldReportCreateState {
  final FieldReport data;
  const FieldReportCreateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'FieldReportCreateSuccess { data: $data }';
}

class FieldReportCreateInvalid extends FieldReportCreateState {
  final FieldReportFormValidationException exception;
  const FieldReportCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'FieldReportCreateInvalid { exception: $exception }';
}

class FieldReportCreateFailure extends FieldReportCreateState {
  final String error;
  const FieldReportCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'FieldReportCreateFailure { error: $error }';
}
