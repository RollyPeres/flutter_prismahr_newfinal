import 'dart:async';

import 'package:flutter_prismahr/app/data/repositories/auth_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({@required this.repository}) : super(AuthUninitialized());
  final AuthRepository repository;

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await repository.hasToken();
      if (hasToken) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      final bool tokenStored = await repository.storeToken(event.token);
      if (tokenStored) yield AuthAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      final bool tokenDeleted = await repository.deleteToken();
      if (tokenDeleted) yield AuthUnauthenticated();
    }
  }
}
