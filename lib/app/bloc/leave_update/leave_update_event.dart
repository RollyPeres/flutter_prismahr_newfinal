part of 'leave_update_bloc.dart';

abstract class LeaveUpdateEvent extends Equatable {
  const LeaveUpdateEvent();

  @override
  List<Object> get props => [];
}

class SubmitButtonPressed extends LeaveUpdateEvent {
  final int id;
  final String reason;
  final String startDate;
  final String endDate;
  final String details;

  const SubmitButtonPressed({
    @required this.id,
    @required this.reason,
    @required this.startDate,
    @required this.endDate,
    @required this.details,
  });

  @override
  List<Object> get props => [
        id,
        reason,
        startDate,
        endDate,
        details,
      ];

  @override
  String toString() => 'SubmitButtonPressed '
      '{'
      ' id: $id,'
      ' reason: $reason,'
      ' startDate: $startDate,'
      ' endDate: $endDate,'
      ' details: $details, '
      '}';
}

class ResetState extends LeaveUpdateEvent {}
