import 'dart:async';

import 'package:flutter_prismahr/app/data/models/user_model.dart';
import 'package:flutter_prismahr/app/data/providers/auth_provider.dart';
import 'package:flutter_prismahr/utils/preferences.dart';
import 'package:meta/meta.dart';

class AuthRepository {
  AuthRepository({@required this.provider}) : assert(provider != null);
  final AuthProvider provider;

  Future authenticate({
    @required String email,
    @required String password,
    @required String userAgent,
  }) async {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    data['user_agent'] = userAgent;
    return provider.authenticate(data: data);
  }

  Future<User> fetchProfile() {
    return provider.fetchProfile();
  }

  Future<bool> logout(Map<String, dynamic> data) async {
    bool loggedOut = await provider.logout(data);

    if (!loggedOut) return false;
    return Preferences.removeToken();
  }

  Future<bool> storeToken(String token) async {
    return Preferences.setToken(token);
  }

  Future<bool> hasToken() async {
    return Preferences.hasToken();
  }
}
