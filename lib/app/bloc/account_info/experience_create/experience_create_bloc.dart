import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/account_info/experience_model.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/experience_repository.dart';

part 'experience_create_event.dart';
part 'experience_create_state.dart';

class ExperienceCreateBloc
    extends Bloc<ExperienceCreateEvent, ExperienceCreateState> {
  ExperienceCreateBloc() : super(ExperienceCreateInitial());

  final ExperienceRepository repository = ExperienceRepository();

  @override
  Stream<ExperienceCreateState> mapEventToState(
    ExperienceCreateEvent event,
  ) async* {
    if (event is ExperienceCreateSubmitButtonPressed) {
      yield ExperienceCreateLoading();

      try {
        final bool workPeriodIsPresent = event.present.toLowerCase() == 'true';

        final Map<String, dynamic> data = Map<String, dynamic>();
        data['company'] = event.company;
        data['position'] = event.position;
        data['period_start_year'] = int.parse(event.periodStartYear);
        data['period_start_month'] = int.parse(event.periodStartMonth);
        data['present'] = workPeriodIsPresent ? 1 : 0;
        data['specialization'] = event.specialization;
        data['workfield'] = event.workfield;
        data['country'] = event.country;
        data['industry'] = event.industry;
        data['role'] = event.role;
        data['salary_currency'] = event.salaryCurrency;
        data['salary'] = int.parse(event.salary);
        data['description'] = event.description;

        if (!workPeriodIsPresent) {
          data['period_end_year'] = int.parse(event.periodEndYear);
          data['period_end_month'] = int.parse(event.periodEndMonth);
        }

        final response = await repository.add(data);

        if (response is ExperienceFormValidationException) {
          yield ExperienceCreateInvalid(exception: response);
          return;
        }

        yield ExperienceCreateSuccess(data: response);
      } catch (e) {
        yield ExperienceCreateFailure(error: e);
      }
    }
  }
}
