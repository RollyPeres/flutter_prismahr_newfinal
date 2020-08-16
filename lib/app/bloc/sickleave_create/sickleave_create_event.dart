part of 'sickleave_create_bloc.dart';

abstract class SickleaveCreateEvent extends Equatable {
  const SickleaveCreateEvent();

  @override
  List<Object> get props => [];
}

class SubmitButtonPressed extends SickleaveCreateEvent {
  final String reason;
  final String startDate;
  final String endDate;
  final String details;
  final List<MultipartFile> receipts;

  const SubmitButtonPressed({
    @required this.reason,
    @required this.startDate,
    @required this.endDate,
    @required this.details,
    @required this.receipts,
  });

  @override
  List<Object> get props => [
        reason,
        startDate,
        endDate,
        receipts,
        details,
      ];

  @override
  String toString() => 'SubmitButtonPressed '
      '{'
      ' reason: $reason,'
      ' startDate: $startDate,'
      ' endDate: $endDate,'
      ' details: $details,'
      ' receipts: $receipts, '
      '}';
}
