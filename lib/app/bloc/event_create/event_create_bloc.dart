import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/event_form_validation_exception_model.dart';
import 'package:flutter_prismahr/app/data/models/event_model.dart';
import 'package:flutter_prismahr/app/data/repositories/event_repository.dart';
import 'package:meta/meta.dart';

part 'event_create_event.dart';
part 'event_create_state.dart';

class EventCreateBloc extends Bloc<EventCreateEvent, EventCreateState> {
  EventCreateBloc() : super(EventCreateInitial());

  final EventRepository repository = EventRepository();

  @override
  Stream<EventCreateState> mapEventToState(
    EventCreateEvent event,
  ) async* {
    if (event is SubmitButtonPressed) {
      yield EventCreateLoading();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['name'] = event.name;
        data['date'] = event.date;
        data['details'] = event.details;
        data['location'] = event.location;
        data['participants'] = event.participants;

        final response = await repository.add(data);

        if (response is EventFormValidationException) {
          yield EventCreateInvalid(exception: response);
        } else {
          yield EventCreateSuccess(data: response);
        }
      } catch (e) {
        yield EventCreateFailure(error: e.toString());
      }
    }
  }
}
