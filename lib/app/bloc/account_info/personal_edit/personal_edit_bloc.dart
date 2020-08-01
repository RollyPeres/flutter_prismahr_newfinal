import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_model.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/personal_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/account_info/personal_edit_validation_exception_model.dart';

part 'personal_edit_event.dart';
part 'personal_edit_state.dart';

class PersonalEditBloc extends Bloc<PersonalEditEvent, PersonalEditState> {
  final PersonalRepository repository;

  PersonalEditBloc({
    @required this.repository,
  }) : super(PersonalEditInitial());

  @override
  Stream<PersonalEditState> mapEventToState(
    PersonalEditEvent event,
  ) async* {
    if (event is PersonalEditSubmitButtonPressed) {
      yield PersonalEditLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['gender'] = event.gender;
        data['birthplace'] = event.birthplace;
        data['birthdate'] = _formatDate(event.birthdate);
        data['marital_status'] = event.maritalStatus;
        data['religion'] = event.religion;
        data['blood_type'] = event.bloodType;
        data['identity_number'] = int.parse(event.idNumber);
        data['identity_type'] = event.idType;
        data['identity_expiry_date'] = _formatDate(event.idExpiryDate);
        data['address'] = event.address;
        data['current_address'] = event.addressCurrent;
        data['postcode'] = int.parse(event.postcode);

        final response = await repository.update(data);

        if (response is PersonalEditValidationException) {
          yield PersonalEditInvalid(exception: response);
          return;
        }

        yield PersonalEditSuccess(data: response);
      } catch (error) {
        yield PersonalEditFailure(error: error);
      }
    }
  }

  String _formatDate(String value) {
    return DateFormat('yyyy-MM-dd')
        .format(DateFormat('MMMM dd, yyyy').parse(value));
  }
}
