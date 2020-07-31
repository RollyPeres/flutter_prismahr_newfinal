import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_prismahr/utils/preferences.dart';

class AttachTokenInterceptor extends Interceptor {
  @override
  Future<FutureOr> onRequest(RequestOptions options) async {
    final bool tokenAvailable = await Preferences.hasToken();

    if (tokenAvailable) {
      final String token = await Preferences.getToken();
      options.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }

    return options;
  }
}
