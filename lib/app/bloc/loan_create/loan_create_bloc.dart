import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/loan_model.dart';
import 'package:flutter_prismahr/app/data/repositories/loan_repository.dart';
import 'package:flutter_prismahr/app/data/repositories/loan_tenor_repository.dart';
import 'package:meta/meta.dart';

part 'loan_create_event.dart';
part 'loan_create_state.dart';

class LoanCreateBloc extends Bloc<LoanCreateEvent, LoanCreateState> {
  LoanCreateBloc() : super(LoanCreateInitial());

  final LoanRepository repository = LoanRepository();
  final LoanTenorRepository loanTenorRepository = LoanTenorRepository();

  @override
  Stream<LoanCreateState> mapEventToState(
    LoanCreateEvent event,
  ) async* {
    if (event is LoanCreateScreenInitialized) {
      yield LoanCreateLoading();

      try {
        final loanTenors = await loanTenorRepository.fetch();
        yield LoanCreateLoaded(loanTenors: loanTenors ?? <LoanTenor>[]);
      } catch (e) {}
    }

    if (event is SubmitButtonPressed) {
      yield LoanCreateSubmitting();

      try {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['nominal'] = event.nominal;
        data['loan_tenor_id'] = event.loanTenorId;
        data['loan_purpose_id'] = event.loanPurposeId;

        final response = await repository.add(data);

        if (response is LoanFormValidationException) {
          yield LoanCreateInvalid(exception: response);
          return;
        }

        yield LoanCreateSuccess(data: response);
      } catch (e) {
        yield LoanCreateFailure(error: e.toString());
      }
    }
  }
}
