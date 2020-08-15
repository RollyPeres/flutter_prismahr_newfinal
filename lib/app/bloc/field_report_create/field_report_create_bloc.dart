import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/field_report_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/field_report_model.dart';
import 'package:flutter_prismahr/app/data/repositories/field_report_repository.dart';

part 'field_report_create_event.dart';
part 'field_report_create_state.dart';

class FieldReportCreateBloc
    extends Bloc<FieldReportCreateEvent, FieldReportCreateState> {
  FieldReportCreateBloc() : super(FieldReportCreateInitial());

  final FieldReportRepository repository = FieldReportRepository();

  @override
  Stream<FieldReportCreateState> mapEventToState(
    FieldReportCreateEvent event,
  ) async* {
    if (event is FieldReportCreateSubmitButtonPressed) {
      yield FieldReportCreateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['title'] = event.title;
        data['chronology'] = event.chronology;
        data['images'] = event.images;
        data['participants'] = event.participants;

        final response = await repository.add(data);

        if (response is FieldReportFormValidationException) {
          yield FieldReportCreateInvalid(exception: response);
          return;
        }

        yield FieldReportCreateSuccess(data: response);
      } catch (e) {
        yield FieldReportCreateFailure(error: e.toString());
      }
    }
  }
}
