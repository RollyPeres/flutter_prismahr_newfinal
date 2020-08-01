import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({Key key}) : super(key: key);

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = BlocProvider.of<ThemeBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          var themeIsDarkMode = state.themeMode == ThemeMode.dark;
          return CupertinoSwitch(
            activeColor: Theme.of(context).primaryColor,
            value: themeIsDarkMode,
            onChanged: (_) {
              if (themeIsDarkMode) {
                _themeBloc.add(
                  ThemeSwitched(themeMode: ThemeMode.light),
                );
              } else {
                _themeBloc.add(ThemeSwitched(themeMode: ThemeMode.dark));
              }
            },
          );
        },
      ),
    );
  }
}
