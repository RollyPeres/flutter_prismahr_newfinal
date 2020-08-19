part of 'loan_bloc.dart';

abstract class LoanEvent extends Equatable {
  const LoanEvent();

  @override
  List<Object> get props => [];
}

class LoanScreenInitialized extends LoanEvent {}

class LoanAdded extends LoanEvent {
  final Loan data;
  const LoanAdded({@required this.data}) : assert(data != null);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'LoanAdded { data: $data }';
}
