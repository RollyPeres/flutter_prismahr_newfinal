import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';

class Logo extends StatelessWidget {
  const Logo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state.themeMode == ThemeMode.dark) {
          return Image.asset('assets/images/logo-dark.png');
        }
        return Image.asset('assets/images/logo.png');
      },
    );
  }
}
