import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/leave_model.dart';
import 'package:flutter_prismahr/app/data/repositories/leave_repository.dart';
import 'package:meta/meta.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(LeaveInitial());

  final LeaveRepository repository = LeaveRepository();

  @override
  Stream<LeaveState> mapEventToState(
    LeaveEvent event,
  ) async* {
    if (event is LeaveScreenInitialized) {
      yield LeaveLoading();

      try {
        final response = await repository.fetch();
        if (response is List<Leave> && response.isNotEmpty) {
          yield LeaveLoaded(data: response);
        } else {
          yield LeaveEmpty();
        }
      } catch (e) {
        yield LeaveFailure(error: e.toString());
      }
    }

    if (event is LeaveAdded) {
      yield LeaveCreated(data: event.data);
    }
  }
}
