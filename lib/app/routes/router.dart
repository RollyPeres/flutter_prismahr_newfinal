import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/leave/leave_bloc.dart';
import 'package:flutter_prismahr/app/bloc/leave_create/leave_create_bloc.dart';
import 'package:flutter_prismahr/app/bloc/leave_update/leave_update_bloc.dart';
import 'package:flutter_prismahr/app/routes/route_arguments.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/views/account_info/contacts/contact.dart';
import 'package:flutter_prismahr/app/views/account_info/contacts/contact_add.dart';
import 'package:flutter_prismahr/app/views/account_info/education/education.dart';
import 'package:flutter_prismahr/app/views/account_info/education/education_add.dart';
import 'package:flutter_prismahr/app/views/account_info/experiences/experience.dart';
import 'package:flutter_prismahr/app/views/account_info/experiences/experience_add.dart';
import 'package:flutter_prismahr/app/views/account_info/index.dart';
import 'package:flutter_prismahr/app/views/account_info/personal/personal.dart';
import 'package:flutter_prismahr/app/views/account_info/personal/personal_edit.dart';
import 'package:flutter_prismahr/app/views/event/create.dart';
import 'package:flutter_prismahr/app/views/event/index.dart';
import 'package:flutter_prismahr/app/views/field_report/create.dart';
import 'package:flutter_prismahr/app/views/field_report/index.dart';
import 'package:flutter_prismahr/app/views/field_report/show.dart';
import 'package:flutter_prismahr/app/views/field_report/update.dart';
import 'package:flutter_prismahr/app/views/home/home.dart';
import 'package:flutter_prismahr/app/views/leave/create.dart';
import 'package:flutter_prismahr/app/views/leave/index.dart';
import 'package:flutter_prismahr/app/views/leave/show.dart';
import 'package:flutter_prismahr/app/views/leave/update.dart';
import 'package:flutter_prismahr/app/views/loan/create.dart';
import 'package:flutter_prismahr/app/views/loan/index.dart';
import 'package:flutter_prismahr/app/views/map.dart';
import 'package:flutter_prismahr/app/views/reimburse/create.dart';
import 'package:flutter_prismahr/app/views/reimburse/index.dart';
import 'package:flutter_prismahr/app/views/sickleave/create.dart';
import 'package:flutter_prismahr/app/views/sickleave/index.dart';

class Router {
  // Provide a function to handle named routes. Use this function to
  // identify the named route being pushed, and create the correct
  // screen.
  final _leaveBloc = LeaveBloc();
  final _leaveUpdateBloc = LeaveUpdateBloc();
  final _leaveCreateBloc = LeaveCreateBloc();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final RouteArguments args = settings.arguments;

    switch (settings.name) {
      case Routes.HOME:
        return MaterialPageRoute(
          builder: (_) => HomePage(),
        );

      case Routes.ACCOUNT_INFO:
        return MaterialPageRoute(
          builder: (_) => AccountInfoScreen(),
        );

      case Routes.ACCOUNT_INFO_PERSONAL:
        return MaterialPageRoute(
          builder: (_) => PersonalScreen(),
        );

      case Routes.ACCOUNT_INFO_PERSONAL_EDIT:
        return MaterialPageRoute(
          builder: (_) => PersonalEditScreen(
            data: args.model,
          ),
        );

      case Routes.EDUCATION_INFO:
        return MaterialPageRoute(
          builder: (_) => EducationScreen(),
        );

      case Routes.EDUCATION_INFO_ADD:
        return MaterialPageRoute(
          builder: (_) => EducationAddScreen(),
        );

      case Routes.EXPERIENCE_INFO:
        return MaterialPageRoute(
          builder: (_) => ExperienceScreen(),
        );

      case Routes.EXPERIENCE_INFO_ADD:
        return MaterialPageRoute(
          builder: (_) => ExperienceAddScreen(),
        );

      case Routes.CONTACT_INFO:
        return MaterialPageRoute(
          builder: (_) => ContactScreen(),
        );

      case Routes.CONTACT_INFO_ADD:
        return MaterialPageRoute(
          builder: (_) => ContactAddScreen(),
        );

      case Routes.FIELD_REPORT:
        return MaterialPageRoute(
          builder: (_) => FieldReportScreen(),
        );

      case Routes.FIELD_REPORT_SHOW:
        return MaterialPageRoute(
          builder: (_) => FieldReportShowScreen(
            fieldReport: args.model,
            fieldReportBloc: args.bloc,
          ),
        );

      case Routes.FIELD_REPORT_CREATE:
        return MaterialPageRoute(
          builder: (_) => FieldReportCreateScreen(),
        );

      case Routes.FIELD_REPORT_UPDATE:
        return MaterialPageRoute(
          builder: (_) => FieldReportUpdateScreen(),
        );

      case Routes.SICKLEAVE:
        return MaterialPageRoute(
          builder: (_) => SickleaveScreen(),
        );

      case Routes.SICKLEAVE_CREATE:
        return MaterialPageRoute(
          builder: (_) => SickleaveCreateScreen(),
        );

      case Routes.LEAVE:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _leaveBloc),
              BlocProvider.value(value: _leaveUpdateBloc),
              BlocProvider.value(value: _leaveCreateBloc),
            ],
            child: LeaveScreen(),
          ),
        );

      case Routes.LEAVE_CREATE:
        return MaterialPageRoute(
          builder: (_) => LeaveCreateScreen(),
        );

      case Routes.LEAVE_SHOW:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _leaveBloc),
              BlocProvider.value(value: _leaveUpdateBloc),
              BlocProvider.value(value: _leaveCreateBloc),
            ],
            child: LeaveShowScreen(data: args.model),
          ),
        );

      case Routes.LEAVE_UPDATE:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _leaveUpdateBloc,
            child: LeaveUpdateScreen(data: args.model),
          ),
        );

      case Routes.REIMBURSE:
        return MaterialPageRoute(
          builder: (_) => ReimburseScreen(),
        );

      case Routes.REIMBURSE_CREATE:
        return MaterialPageRoute(
          builder: (_) => ReimburseCreateScreen(),
        );

      case Routes.LOAN:
        return MaterialPageRoute(
          builder: (_) => LoanScreen(),
        );

      case Routes.LOAN_CREATE:
        return MaterialPageRoute(
          builder: (_) => LoanCreateScreen(),
        );

      case Routes.EVENT:
        return MaterialPageRoute(
          builder: (_) => EventScreen(),
        );

      case Routes.EVENT_CREATE:
        return MaterialPageRoute(
          builder: (_) => EventCreateScreen(),
        );

      case Routes.MAP:
        return MaterialPageRoute(
          builder: (_) => MapScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  void dispose() {
    print('DISPOSE FROM ROUTER IS CALLED');

    _leaveBloc.close();
    _leaveUpdateBloc.close();
    _leaveCreateBloc.close();
  }
}
