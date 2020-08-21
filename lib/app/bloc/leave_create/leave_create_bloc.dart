import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:flutter_prismahr/app/data/repositories/leave_repository.dart';
import 'package:meta/meta.dart';

part 'leave_create_event.dart';
part 'leave_create_state.dart';

class LeaveCreateBloc extends Bloc<LeaveCreateEvent, LeaveCreateState> {
  LeaveCreateBloc() : super(LeaveCreateInitial());

  final LeaveRepository repository = LeaveRepository();

  @override
  Stream<LeaveCreateState> mapEventToState(
    LeaveCreateEvent event,
  ) async* {
    if (event is SubmitButtonPressed) {
      yield LeaveCreateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['reason'] = event.reason;
        data['start_date'] = event.startDate;
        data['end_date'] = event.endDate;
        data['details'] = event.details;

        final response = await repository.add(data);

        if (response is LeaveFormValidationException) {
          yield LeaveCreateInvalid(exception: response);
          return;
        }

        yield LeaveCreateSuccess(data: response);
      } catch (e) {
        yield LeaveCreateFailure(error: e.toString());
      }
    }
  }
}
