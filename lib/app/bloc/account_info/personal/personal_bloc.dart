import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/personal_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_model.dart';

part 'personal_event.dart';
part 'personal_state.dart';

class PersonalBloc extends Bloc<PersonalEvent, PersonalState> {
  final PersonalRepository repository;

  PersonalBloc({
    @required this.repository,
  }) : super(PersonalInitial());

  @override
  Stream<PersonalState> mapEventToState(
    PersonalEvent event,
  ) async* {
    if (event is PersonalScreenInitialized) {
      yield PersonalLoading();

      try {
        final personalInfo = await repository.fetch();
        yield PersonalLoaded(data: personalInfo);
      } catch (e) {
        yield PersonalFailure(error: e.toString());
      }
    }

    if (event is PersonalDataUpdated) {
      yield PersonalLoaded(data: event.data);
    }
  }
}
