import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/account_info/education_model.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/education_repository.dart';
import 'package:meta/meta.dart';

part 'education_event.dart';
part 'education_state.dart';

class EducationBloc extends Bloc<EducationEvent, EducationState> {
  final EducationRepository repository;

  EducationBloc({@required this.repository})
      : assert(repository != null),
        super(EducationInitial());

  @override
  Stream<EducationState> mapEventToState(
    EducationEvent event,
  ) async* {
    if (event is EducationScreenInitialized) {
      yield EducationLoading();

      try {
        final educations = await repository.fetch();

        if (educations is List && educations.isEmpty) {
          yield EducationEmpty();
        }

        yield EducationLoaded(data: educations);
      } catch (error) {
        yield EducationFailure(error: error.toString());
      }
    }

    if (event is EducationAdded) {
      yield EducationCreated(education: event.data);
    }
  }
}
