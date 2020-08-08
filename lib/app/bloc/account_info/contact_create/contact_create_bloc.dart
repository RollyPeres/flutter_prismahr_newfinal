import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_model.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/contact_repository.dart';

part 'contact_create_event.dart';
part 'contact_create_state.dart';

class ContactCreateBloc extends Bloc<ContactCreateEvent, ContactCreateState> {
  ContactCreateBloc() : super(ContactCreateInitial());

  final ContactRepository repository = ContactRepository();

  @override
  Stream<ContactCreateState> mapEventToState(
    ContactCreateEvent event,
  ) async* {
    if (event is ContactCreateSubmitButtonPressed) {
      yield ContactCreateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['relation'] = event.relation;
        data['name'] = event.name;
        data['phone'] = event.phone;
        data['phone_alt'] = event.phoneAlt;

        final response = await repository.add(data);

        if (response is ContactFormValidationException) {
          yield ContactCreateInvalid(exception: response);
          return;
        }

        yield ContactCreateSuccess(data: response);
      } catch (e) {
        yield ContactCreateFailure(error: e);
      }
    }
  }
}
