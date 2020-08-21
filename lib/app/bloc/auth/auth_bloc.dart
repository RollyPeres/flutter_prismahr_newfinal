import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
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
      // await Preferences.removeToken();
      final bool hasToken = await repository.hasToken();
      final User user = await repository.fetchProfile();
      if (hasToken) {
        yield AuthAuthenticated(user: user);
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      final bool tokenStored = await repository.storeToken(event.token);
      final User user = await repository.fetchProfile();
      if (tokenStored) yield AuthAuthenticated(user: user);
    }

    if (event is LoggedOut) {
      final Map<String, dynamic> data = Map<String, dynamic>();
      data['user_agent'] = _getPlatformSpecificInformation();

      final bool tokenDeleted = await repository.logout(data);
      if (tokenDeleted) yield AuthUnauthenticated();
    }
  }

  Future<String> _getPlatformSpecificInformation() async {
    if (Platform.isIOS) {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      return iosInfo.name;
    }

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.device;
  }
}
