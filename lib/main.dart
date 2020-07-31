import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_prismahr/app/bloc/auth/auth_bloc.dart';
import 'package:flutter_prismahr/app/bloc/theme/theme_bloc.dart';
import 'package:flutter_prismahr/app/bloc/simple_bloc_observer.dart';
import 'package:flutter_prismahr/app/data/providers/auth_provider.dart';
import 'package:flutter_prismahr/app/data/repositories/auth_repository.dart';
import 'package:flutter_prismahr/app/routes/router.dart';
import 'package:flutter_prismahr/app/routes/routes.dart';
import 'package:flutter_prismahr/app/themes/themes.dart';
import 'package:flutter_prismahr/app/views/home.dart';
import 'package:flutter_prismahr/app/views/login.dart';
import 'package:flutter_prismahr/app/views/splash.dart';
import 'package:flutter_prismahr/utils/request.dart';
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

  runApp(MyApp(
    repository: AuthRepository(
      provider: AuthProvider(
        httpClient: Request.dio,
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  final AuthRepository repository;
  MyApp({@required this.repository});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthBloc authBloc;
  AuthRepository get repository => widget.repository;

  @override
  void initState() {
    authBloc = AuthBloc(repository: repository);
    authBloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Lock device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => authBloc),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: _buildWithTheme,
        ),
      ),
    );
  }

  Widget _buildWithTheme(
    BuildContext context,
    ThemeState state,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: DotEnv().env['APP_NAME'],
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      themeMode: state.themeMode,
      initialRoute: Routes.HOME,
      onGenerateRoute: Router.generateRoute,
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUnauthenticated) {
            return LoginScreen(repository: repository);
          }

          if (state is AuthAuthenticated) {
            return HomePage();
          }

          return SplashScreen();
        },
      ),
    );
  }

  @override
  void dispose() {
    authBloc.close();
    super.dispose();
  }
}
