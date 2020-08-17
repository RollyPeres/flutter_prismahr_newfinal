part of 'reimburse_create_bloc.dart';

abstract class ReimburseCreateEvent extends Equatable {
  const ReimburseCreateEvent();

  @override
  List<Object> get props => [];
}

class SubmitButtonPressed extends ReimburseCreateEvent {
  final int reimburseTypeId;
  final String reason;
  final String date;
  final int nominal;
  final String details;
  final List<MultipartFile> receipts;

  const SubmitButtonPressed({
    @required this.reimburseTypeId,
    @required this.reason,
    @required this.date,
    @required this.nominal,
    @required this.details,
    @required this.receipts,
  });

  @override
  List<Object> get props => [
        reimburseTypeId,
        reason,
        date,
        nominal,
        details,
        receipts,
      ];

  @override
  String toString() => 'SubmitButtonPressed '
      '{'
      ' reimburseTypeId: $reimburseTypeId,'
      ' reason: $reason,'
      ' date: $date,'
      ' nominal: $nominal,'
      ' details: $details,'
      ' receipts: $receipts, '
      '}';
}
