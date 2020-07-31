import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeSwitched) {
      yield _mapSelectedThemeToThemeMode(event.themeMode);
      return;
    }
  }

  ThemeState _mapSelectedThemeToThemeMode(ThemeMode themeMode) {
    ThemeState theme;

    switch (themeMode) {
      case ThemeMode.dark:
        theme = ThemeState(themeMode: ThemeMode.dark);
        break;

      case ThemeMode.system:
        theme = ThemeState(themeMode: ThemeMode.system);
        break;

      default:
        theme = ThemeState(themeMode: ThemeMode.light);
    }

    return theme;
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    return ThemeState(
      themeMode: _mapNameToThemeMode(json['theme']),
    );
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return {
      'theme': _mapThemeToName(state.themeMode),
    };
  }

  ThemeMode _mapNameToThemeMode(String name) {
    switch (name) {
      case 'darkTheme':
        return ThemeMode.dark;
        break;

      case 'systemTheme':
        return ThemeMode.system;
        break;

      default:
        return ThemeMode.light;
    }
  }

  String _mapThemeToName(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.dark:
        return 'darkTheme';

      case ThemeMode.system:
        return 'systemTheme';

      default:
        return 'default';
    }
  }
}
