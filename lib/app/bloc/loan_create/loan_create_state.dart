part of 'loan_create_bloc.dart';

abstract class LoanCreateState extends Equatable {
  const LoanCreateState();

  @override
  List<Object> get props => [];
}

class LoanCreateInitial extends LoanCreateState {}

class LoanCreateLoading extends LoanCreateState {}

class LoanCreateLoaded extends LoanCreateState {
  final List<LoanTenor> loanTenors;
  const LoanCreateLoaded({@required this.loanTenors});

  @override
  List<Object> get props => [loanTenors];

  @override
  String toString() => 'LoanCreateLoaded { loanTenors: $loanTenors }';
}

class LoanCreateSubmitting extends LoanCreateState {}

class LoanCreateSuccess extends LoanCreateState {
  final Loan data;
  const LoanCreateSuccess({@required this.data});

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LoanCreateSuccess { data: $data }';
}

class LoanCreateInvalid extends LoanCreateState {
  final LoanFormValidationException exception;
  const LoanCreateInvalid({@required this.exception})
      : assert(exception != null);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'LoanCreateInvalid { exception: $exception }';
}

class LoanCreateFailure extends LoanCreateState {
  final String error;
  const LoanCreateFailure({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoanCreateFailure { error: $error }';
}
