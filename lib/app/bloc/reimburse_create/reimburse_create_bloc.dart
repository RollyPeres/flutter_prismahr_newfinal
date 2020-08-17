import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_prismahr/app/data/models/reimburse_model.dart';
import 'package:flutter_prismahr/app/data/repositories/reimburse_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'reimburse_create_event.dart';
part 'reimburse_create_state.dart';

class ReimburseCreateBloc
    extends Bloc<ReimburseCreateEvent, ReimburseCreateState> {
  ReimburseCreateBloc() : super(ReimburseCreateInitial());

  final ReimburseRepository repository = ReimburseRepository();

  @override
  Stream<ReimburseCreateState> mapEventToState(
    ReimburseCreateEvent event,
  ) async* {
    if (event is SubmitButtonPressed) {
      yield ReimburseCreateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['reimburse_type_id'] = event.reimburseTypeId;
        data['reason'] = event.reason;
        data['date'] = event.date;
        data['nominal'] = event.nominal;
        data['details'] = event.details;
        data['receipts'] = event.receipts;

        final response = await repository.add(data);

        if (response is ReimburseFormValidationException) {
          yield ReimburseCreateInvalid(exception: response);
        } else {
          yield ReimburseCreateSuccess(data: response);
        }
      } catch (e) {
        yield ReimburseCreateFailure(error: e.toString());
      }
    }
  }
}
