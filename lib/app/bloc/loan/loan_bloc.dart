import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/app/data/repositories/loan_repository.dart';

part 'loan_event.dart';
part 'loan_state.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  LoanBloc() : super(LoanInitial());

  final LoanRepository repository = LoanRepository();

  @override
  Stream<LoanState> mapEventToState(
    LoanEvent event,
  ) async* {
    if (event is LoanScreenInitialized) {
      yield LoanLoading();

      try {
        final response = await repository.fetch();
        if (response is List<Loan> && response.isNotEmpty) {
          yield LoanLoaded(data: response);
        } else {
          yield LoanEmpty();
        }
      } catch (e) {
        yield LoanFailure(error: e.toString());
      }
    }

    if (event is LoanAdded) {
      yield LoanCreated(data: event.data);
    }
  }
}
