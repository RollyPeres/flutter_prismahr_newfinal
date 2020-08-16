import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/repositories/sickleave_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/sickleave_model.dart';

part 'sickleave_event.dart';
part 'sickleave_state.dart';

class SickleaveBloc extends Bloc<SickleaveEvent, SickleaveState> {
  SickleaveBloc() : super(SickleaveInitial());

  final SickleaveRepository repository = SickleaveRepository();

  @override
  Stream<SickleaveState> mapEventToState(
    SickleaveEvent event,
  ) async* {
    if (event is SickleaveScreenInitialized) {
      yield SickleaveLoading();

      try {
        final response = await repository.fetch();
        if (response is List<Sickleave> && response.isNotEmpty) {
          yield SickleaveLoaded(data: response);
        } else {
          yield SickleaveEmpty();
        }
      } catch (e) {
        yield SickleaveFailure(error: e.toString());
      }
    }

    if (event is SickleaveAdded) {
      yield SickleaveCreated(data: event.data);
    }
  }
}
