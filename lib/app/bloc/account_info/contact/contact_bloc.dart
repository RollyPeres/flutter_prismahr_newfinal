import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/account_info/contact_model.dart';
import 'package:flutter_prismahr/app/data/repositories/account_info/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial());

  final ContactRepository repository = ContactRepository();

  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is ContactScreenInitialized) {
      yield ContactLoading();

      try {
        final contacts = await repository.fetch();

        if (contacts == null) {
          yield ContactEmpty();
          return;
        }

        yield ContactLoaded(data: contacts);
      } catch (e) {
        yield ContactFailure(error: e);
      }
    }

    if (event is ContactAdded) {
      yield ContactCreated(data: event.data);
    }
  }
}
