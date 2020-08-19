part of 'loan_create_bloc.dart';

abstract class LoanCreateEvent extends Equatable {
  const LoanCreateEvent();

  @override
  List<Object> get props => [];
}

class LoanCreateScreenInitialized extends LoanCreateEvent {}

class SubmitButtonPressed extends LoanCreateEvent {
  final int nominal;
  final int loanTenorId;
  final int loanPurposeId;

  const SubmitButtonPressed({
    @required this.nominal,
    @required this.loanTenorId,
    @required this.loanPurposeId,
  });

  @override
  List<Object> get props => [
        nominal,
        loanTenorId,
        loanPurposeId,
      ];

  @override
  String toString() => 'SubmitButtonPressed '
      '{'
      ' nominal: $nominal,'
      ' loanTenorId: $loanTenorId,'
      ' loanPurposeId: $loanPurposeId, '
      '}';
}
