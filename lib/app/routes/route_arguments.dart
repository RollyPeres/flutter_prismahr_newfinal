import 'package:meta/meta.dart';

class RouteArguments {
  final dynamic model;
  final dynamic bloc;

  RouteArguments({
    @required this.model,
    @required this.bloc,
  }) : assert(model != null, bloc != null);
}
