import 'dart:async';

import 'package:flutter_prismahr/app/bloc/auth/auth_bloc.dart';
import 'package:flutter_prismahr/app/data/repositories/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;
  final AuthBloc authBloc;

  LoginBloc({
    @required this.repository,
    @required this.authBloc,
  }) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await repository.authenticate(
          email: event.email,
          password: event.password,
          userAgent: event.userAgent,
        );

        final user = await repository.fetchProfile();
        authBloc.add(LoggedIn(token: token, user: user));
        yield LoginInitial();
      } catch (e) {
        yield LoginFailure(error: e.toString());
      }
    }
  }
}
