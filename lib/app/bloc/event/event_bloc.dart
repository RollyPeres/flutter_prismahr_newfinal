import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/event_model.dart';
import 'package:flutter_prismahr/app/data/repositories/event_repository.dart';
import 'package:meta/meta.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial());

  final EventRepository repository = EventRepository();

  @override
  Stream<EventState> mapEventToState(
    EventEvent event,
  ) async* {
    if (event is EventScreenInitialized) {
      yield EventLoading();

      try {
        final response = await repository.fetch();
        if (response is List<Event> && response.isNotEmpty) {
          yield EventLoaded(data: response);
        } else {
          yield EventEmpty();
        }
      } catch (e) {
        yield EventFailure(error: e.toString());
      }
    }

    if (event is EventAdded) {
      yield EventCreated(data: event.data);
    }
  }
}
