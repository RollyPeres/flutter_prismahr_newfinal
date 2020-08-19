part of 'loan_bloc.dart';

abstract class LoanState extends Equatable {
  const LoanState();

  @override
  List<Object> get props => [];
}

class LoanInitial extends LoanState {}

class LoanLoading extends LoanState {}

class LoanEmpty extends LoanState {}

class LoanLoaded extends LoanState {
  final List<Loan> data;
  const LoanLoaded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LoanLoaded { data: $data }';
}

class LoanFailure extends LoanState {
  final String error;
  const LoanFailure({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoanFailure { error: $error }';
}

class LoanCreated extends LoanState {
  final Loan data;
  const LoanCreated({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LoanCreated { data: $data }';
}
