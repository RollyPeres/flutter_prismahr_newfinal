import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/sickleave_form_validation_exception.dart';
import 'package:flutter_prismahr/app/data/models/sickleave_model.dart';
import 'package:flutter_prismahr/app/data/repositories/sickleave_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'sickleave_create_event.dart';
part 'sickleave_create_state.dart';

class SickleaveCreateBloc
    extends Bloc<SickleaveCreateEvent, SickleaveCreateState> {
  SickleaveCreateBloc() : super(SickleaveCreateInitial());

  final SickleaveRepository repository = SickleaveRepository();

  @override
  Stream<SickleaveCreateState> mapEventToState(
    SickleaveCreateEvent event,
  ) async* {
    if (event is SubmitButtonPressed) {
      yield SickleaveCreateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['reason'] = event.reason;
        data['start_date'] = event.startDate;
        data['end_date'] = event.endDate;
        data['details'] = event.details;
        data['receipts'] = event.receipts;

        final response = await repository.add(data);

        if (response is SickleaveFormValidationException) {
          yield SickleaveCreateInvalid(exception: response);
          return;
        }

        yield SickleaveCreateSuccess(data: response);
      } catch (e) {
        yield SickleaveCreateFailure(error: e.toString());
      }
    }
  }
}
