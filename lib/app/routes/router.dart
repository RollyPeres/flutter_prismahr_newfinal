import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/account_info.dart';
import 'package:flutter_prismahr/app/views/account_info/personal/personal.dart';
import 'package:flutter_prismahr/app/views/account_info/personal/personal_edit.dart';
import 'package:flutter_prismahr/app/views/home.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.HOME:
        return MaterialPageRoute(builder: (_) => HomePage());

      case Routes.ACCOUNT_INFO:
        return MaterialPageRoute(builder: (_) => AccountInfoScreen());

      case Routes.ACCOUNT_INFO_PERSONAL:
        return MaterialPageRoute(builder: (_) => PersonalScreen());

      case Routes.ACCOUNT_INFO_PERSONAL_EDIT:
        return MaterialPageRoute(
            builder: (_) => PersonalEditScreen(data: settings.arguments));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
