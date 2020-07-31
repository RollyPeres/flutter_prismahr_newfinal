import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_prismahr/app/bloc/theme_bloc.dart';
import 'package:flutter_prismahr/app/bloc_observers/simple_bloc_observer.dart';
import 'package:flutter_prismahr/app/themes/themes.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

void main() async {
  // https://github.com/flutter/flutter/pull/38464
  // Changes in Flutter v1.9.4 require you to call WidgetsFlutterBinding.ensureInitialized()
  // before using any plugins if the code is executed before runApp.
  // As a result, you will need the following line if you're using Flutter >=1.9.4.
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('.env');

  HydratedBloc.storage = await HydratedStorage.build();
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lock device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      child: BlocProvider(
        create: (context) => ThemeBloc(),
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: _buildWithTheme,
        ),
      ),
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: DotEnv().env['APP_NAME'],
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: state.themeMode,
      home: Scaffold(
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
      ),
    );
  }
}
