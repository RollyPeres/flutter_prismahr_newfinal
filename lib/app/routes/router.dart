import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/routes/route_arguments.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/account_info.dart';
import 'package:flutter_prismahr/app/views/account_info/contacts/contact.dart';
import 'package:flutter_prismahr/app/views/account_info/contacts/contact_add.dart';
import 'package:flutter_prismahr/app/views/account_info/education/education.dart';
import 'package:flutter_prismahr/app/views/account_info/education/education_add.dart';
import 'package:flutter_prismahr/app/views/account_info/experiences/experience.dart';
import 'package:flutter_prismahr/app/views/account_info/experiences/experience_add.dart';
import 'package:flutter_prismahr/app/views/account_info/personal/personal.dart';
import 'package:flutter_prismahr/app/views/account_info/personal/personal_edit.dart';
import 'package:flutter_prismahr/app/views/field_report/create.dart';
import 'package:flutter_prismahr/app/views/field_report/show.dart';
import 'package:flutter_prismahr/app/views/field_report/update.dart';
import 'package:flutter_prismahr/app/views/home.dart';
import 'package:flutter_prismahr/app/views/field_report.dart';
import 'package:flutter_prismahr/app/views/sickleave.dart';
import 'package:flutter_prismahr/app/views/sickleave/create.dart';

class Router {
  // Provide a function to handle named routes. Use this function to
  // identify the named route being pushed, and create the correct
  // screen.
  static Route<dynamic> generateRoute(RouteSettings settings) {
    RouteArguments args = settings.arguments;

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

      case Routes.EDUCATION_INFO:
        return MaterialPageRoute(builder: (_) => EducationScreen());

      case Routes.EDUCATION_INFO_ADD:
        return MaterialPageRoute(builder: (_) => EducationAddScreen());

      case Routes.EXPERIENCE_INFO:
        return MaterialPageRoute(builder: (_) => ExperienceScreen());

      case Routes.EXPERIENCE_INFO_ADD:
        return MaterialPageRoute(builder: (_) => ExperienceAddScreen());

      case Routes.CONTACT_INFO:
        return MaterialPageRoute(builder: (_) => ContactScreen());

      case Routes.CONTACT_INFO_ADD:
        return MaterialPageRoute(builder: (_) => ContactAddScreen());

      case Routes.FIELD_REPORT:
        return MaterialPageRoute(builder: (_) => FieldReportScreen());

      case Routes.FIELD_REPORT_SHOW:
        return MaterialPageRoute(
          builder: (_) => FieldReportShowScreen(
            fieldReport: args.model,
            fieldReportBloc: args.bloc,
          ),
        );

      case Routes.FIELD_REPORT_CREATE:
        return MaterialPageRoute(builder: (_) => FieldReportCreateScreen());

      case Routes.FIELD_REPORT_UPDATE:
        return MaterialPageRoute(builder: (_) => FieldReportUpdateScreen());

      case Routes.SICKLEAVE:
        return MaterialPageRoute(builder: (_) => SickleaveScreen());

      case Routes.SICKLEAVE_CREATE:
        return MaterialPageRoute(builder: (_) => SickleaveCreateScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
