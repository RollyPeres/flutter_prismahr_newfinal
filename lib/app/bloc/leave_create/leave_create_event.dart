part of 'leave_create_bloc.dart';

abstract class LeaveCreateEvent extends Equatable {
  const LeaveCreateEvent();

  @override
  List<Object> get props => [];
}

class SubmitButtonPressed extends LeaveCreateEvent {
  final String reason;
  final String startDate;
  final String endDate;
  final String details;

  const SubmitButtonPressed({
    @required this.reason,
    @required this.startDate,
    @required this.endDate,
    @required this.details,
  });

  @override
  List<Object> get props => [
        reason,
        startDate,
        endDate,
        details,
      ];

  @override
  String toString() => 'SubmitButtonPressed '
      '{'
      ' reason: $reason,'
      ' startDate: $startDate,'
      ' endDate: $endDate,'
      ' details: $details, '
      '}';
}
