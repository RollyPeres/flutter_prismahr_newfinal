part of 'field_report_update_bloc.dart';

abstract class FieldReportUpdateEvent extends Equatable {
  const FieldReportUpdateEvent();
}

class FieldReportUpdateSubmitButtonPressed extends FieldReportUpdateEvent {
  final int id;
  final String title;
  final String chronology;
  final List<MultipartFile> images;
  final List<int> participants;

  const FieldReportUpdateSubmitButtonPressed({
    @required this.id,
    @required this.title,
    @required this.chronology,
    @required this.images,
    @required this.participants,
  });

  @override
  List<Object> get props => [
        id,
        title,
        chronology,
        images,
        participants,
      ];

  @override
  String toString() => 'FieldReportUpdateSubmitButtonPressed '
      '{'
      ' id: $id,'
      ' title: $title,'
      ' chronology: $chronology,'
      ' images: $images,'
      ' participants: $participants, '
      '}';
}
