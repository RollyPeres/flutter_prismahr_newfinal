import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Hello World!')),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context)
                  .add(ThemeSwitched(themeMode: ThemeMode.light));
            },
            tooltip: 'Increment',
            child: Icon(Icons.lightbulb_outline),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<ThemeBloc>(context)
                  .add(ThemeSwitched(themeMode: ThemeMode.dark));
            },
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
