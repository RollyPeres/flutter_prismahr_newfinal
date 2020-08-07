import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_model.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/experience_repository.dart';

part 'experience_event.dart';
part 'experience_state.dart';

class ExperienceBloc extends Bloc<ExperienceEvent, ExperienceState> {
  ExperienceBloc() : super(ExperienceInitial());

  final ExperienceRepository repository = ExperienceRepository();

  @override
  Stream<ExperienceState> mapEventToState(
    ExperienceEvent event,
  ) async* {
    if (event is ExperienceScreenInitialized) {
      yield ExperienceLoading();

      try {
        final experiences = await repository.fetch();

        if (experiences == null) {
          yield ExperienceEmpty();
          return;
        }

        yield ExperienceLoaded(data: experiences);
      } catch (e) {
        yield ExperienceFailure(error: e);
      }
    }

    if (event is ExperienceAdded) {
      yield ExperienceCreated(data: event.data);
    }
  }
}
