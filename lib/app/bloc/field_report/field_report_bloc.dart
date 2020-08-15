import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/field_report_model.dart';
import 'package:flutter_prismahr/app/data/repositories/field_report_repository.dart';

part 'field_report_event.dart';
part 'field_report_state.dart';

class FieldReportBloc extends Bloc<FieldReportEvent, FieldReportState> {
  FieldReportBloc() : super(FieldReportInitial());

  final FieldReportRepository repository = FieldReportRepository();

  @override
  Stream<FieldReportState> mapEventToState(
    FieldReportEvent event,
  ) async* {
    if (event is FieldReportScreenInitialized) {
      yield FieldReportLoading();

      try {
        final fieldReports = await repository.fetch();

        if (fieldReports != null && fieldReports.isEmpty) {
          yield FieldReportEmpty();
          return;
        }

        yield FieldReportLoaded(data: fieldReports);
      } catch (e) {
        yield FieldReportFailure(error: e);
      }
    }

    if (event is FieldReportAdded) {
      yield FieldReportCreated(data: event.data);
    }

    if (event is DeleteModalConfirmed) {
      try {
        final response = await repository.destroy(event.id);
        if (response != null) {
          yield FieldReportDeleted(data: response);
        }
      } catch (e) {
        print(e);
        // TODO: handle errors.
      }
    }
  }
}
