import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/repositories/field_report_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/field_report_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/field_report_model.dart';

part 'field_report_update_event.dart';
part 'field_report_update_state.dart';

class FieldReportUpdateBloc
    extends Bloc<FieldReportUpdateEvent, FieldReportUpdateState> {
  FieldReportUpdateBloc() : super(FieldReportUpdateInitial());

  final FieldReportRepository repository = FieldReportRepository();

  @override
  Stream<FieldReportUpdateState> mapEventToState(
    FieldReportUpdateEvent event,
  ) async* {
    if (event is FieldReportUpdateSubmitButtonPressed) {
      yield FieldReportUpdateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['title'] = event.title;
        data['chronology'] = event.chronology;
        data['images'] = event.images;
        data['participants'] = event.participants;

        final response = await repository.update(event.id, data);

        if (response is FieldReportFormValidationException) {
          yield FieldReportUpdateInvalid(exception: response);
          return;
        }

        yield FieldReportUpdateSuccess(data: response);
      } catch (e) {
        yield FieldReportUpdateFailure(error: e.toString());
      }
    }
  }
}
