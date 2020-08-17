import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/reimburse_model.dart';
import 'package:flutter_prismahr/app/data/repositories/reimburse_repository.dart';

part 'reimburse_event.dart';
part 'reimburse_state.dart';

class ReimburseBloc extends Bloc<ReimburseEvent, ReimburseState> {
  ReimburseBloc() : super(ReimburseInitial());

  final ReimburseRepository repository = ReimburseRepository();

  @override
  Stream<ReimburseState> mapEventToState(
    ReimburseEvent event,
  ) async* {
    if (event is ReimburseScreenInitialized) {
      yield ReimburseLoading();

      try {
        final response = await repository.fetch();
        if (response is List<Reimburse> && response.isNotEmpty) {
          yield ReimburseLoaded(data: response);
        } else {
          yield ReimburseEmpty();
        }
      } catch (e) {
        yield ReimburseFailure(error: e.toString());
      }
    }

    if (event is ReimburseAdded) {
      yield ReimburseCreated(data: event.data);
    }
  }
}
