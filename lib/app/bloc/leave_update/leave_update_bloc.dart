import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:flutter_prismahr/app/data/repositories/leave_repository.dart';
import 'package:meta/meta.dart';

part 'leave_update_event.dart';
part 'leave_update_state.dart';

class LeaveUpdateBloc extends Bloc<LeaveUpdateEvent, LeaveUpdateState> {
  LeaveUpdateBloc() : super(LeaveUpdateInitial());

  final LeaveRepository repository = LeaveRepository();

  @override
  Stream<LeaveUpdateState> mapEventToState(
    LeaveUpdateEvent event,
  ) async* {
    print('EVENT IS: $event');
    if (event is SubmitButtonPressed) {
      yield LeaveUpdateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['id'] = event.id;
        data['reason'] = event.reason;
        data['start_date'] = event.startDate;
        data['end_date'] = event.endDate;
        data['details'] = event.details;

        final response = await repository.update(data);

        if (response is LeaveFormValidationException) {
          yield LeaveUpdateInvalid(exception: response);
          return;
        }

        yield LeaveUpdateSuccess(data: response);
      } catch (e) {
        yield LeaveUpdateFailure(error: e.toString());
      }
    }

    if (event is ResetState) {
      yield LeaveUpdateInitial();
    }
  }
}
