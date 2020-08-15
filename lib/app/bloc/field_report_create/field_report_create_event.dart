part of 'field_report_create_bloc.dart';

abstract class FieldReportCreateEvent extends Equatable {
  const FieldReportCreateEvent();
}

class FieldReportCreateSubmitButtonPressed extends FieldReportCreateEvent {
  final String title;
  final String chronology;
  final List<MultipartFile> images;
  final List<int> participants;

  const FieldReportCreateSubmitButtonPressed({
    @required this.title,
    @required this.chronology,
    @required this.images,
    @required this.participants,
  });

  @override
  List<Object> get props => [
        title,
        chronology,
        images,
        participants,
      ];

  @override
  String toString() => 'FieldReportCreateSubmitButtonPressed '
      '{'
      ' title: $title,'
      ' chronology: $chronology,'
      ' images: $images,'
      ' participants: $participants, '
      '}';
}
