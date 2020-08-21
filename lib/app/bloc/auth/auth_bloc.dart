import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_prismahr/app/data/models/user_model.dart';
import 'package:flutter_prismahr/app/data/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

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
      await repository.deleteToken();
      final bool hasToken = await repository.hasToken();
      final User user = await repository.fetchProfile();
      if (hasToken) {
        yield AuthAuthenticated(user: user);
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      final bool tokenStored = await repository.storeToken(event.token);
      final User user = await repository.fetchProfile();
      if (tokenStored) yield AuthAuthenticated(user: user);
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      final bool tokenDeleted = await repository.deleteToken();
      if (tokenDeleted) yield AuthUnauthenticated();
    }
  }
}
