import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/education_repository.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/account_info/education_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/account_info/education_model.dart';

part 'education_create_event.dart';
part 'education_create_state.dart';

class EducationCreateBloc
    extends Bloc<EducationCreateEvent, EducationCreateState> {
  final EducationRepository repository;

  EducationCreateBloc({@required this.repository})
      : assert(repository != null),
        super(EducationCreateInitial());

  @override
  Stream<EducationCreateState> mapEventToState(
    EducationCreateEvent event,
  ) async* {
    if (event is EducationCreateSubmitButtonPressed) {
      yield EducationCreateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['institution'] = event.institution;
        data['graduation_month'] = int.parse(event.graduationMonth);
        data['graduation_year'] = int.parse(event.graduationYear);
        data['qualification'] = event.qualification;
        data['location'] = event.location;
        data['field_of_study'] = event.fieldOfStudy;
        data['majors'] = event.majors;
        data['final_score'] = event.finalScore;
        data['additional_info'] = event.additionalInfo;

        final response = await repository.add(data);

        if (response is EducationFormValidationException) {
          yield EducationCreateInvalid(exception: response);
          return;
        }

        yield EducationCreateSuccess(data: response);
      } catch (error) {
        yield EducationCreateFailure(error: error);
      }
    }
  }
}
