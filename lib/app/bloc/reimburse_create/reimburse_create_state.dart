part of 'reimburse_create_bloc.dart';

abstract class ReimburseCreateState extends Equatable {
  const ReimburseCreateState();

  @override
  List<Object> get props => [];
}

class ReimburseCreateInitial extends ReimburseCreateState {}

class ReimburseCreateLoading extends ReimburseCreateState {}

class ReimburseCreateSuccess extends ReimburseCreateState {
  final Reimburse data;
  const ReimburseCreateSuccess({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'ReimburseCreateSuccess { data: $data }';
}

class ReimburseCreateInvalid extends ReimburseCreateState {
  final ReimburseFormValidationException exception;
  const ReimburseCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'ReimburseCreateInvalid { exception: $exception }';
}

class ReimburseCreateFailure extends ReimburseCreateState {
  final String error;
  const ReimburseCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ReimburseCreateFailure { error: $error }';
}
