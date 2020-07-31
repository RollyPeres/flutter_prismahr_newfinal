import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/auth/auth_bloc.dart';
import 'package:flutter_prismahr/app/bloc/login/login_bloc.dart';
import 'package:flutter_prismahr/app/data/repositories/auth_repository.dart';
import 'package:flutter_prismahr/app/views/widgets/login/login_form.dart';

class LoginScreen extends StatefulWidget {
  final AuthRepository repository;

  LoginScreen({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  AuthBloc _authBloc;
  AuthRepository get _authRepo => widget.repository;

  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _loginBloc = LoginBloc(
      authBloc: _authBloc,
      repository: _authRepo,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: LoginForm(
          authBloc: _authBloc,
          loginBloc: _loginBloc,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
