import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_prismahr/app/bloc/auth/auth_bloc.dart';
import 'package:flutter_prismahr/app/bloc/login/login_bloc.dart';
import 'package:flutter_prismahr/app/components/button.dart';
import 'package:flutter_prismahr/app/components/form_input.dart';
import 'package:flutter_prismahr/app/components/logo.dart';

class LoginForm extends StatefulWidget {
  final LoginBloc loginBloc;
  final AuthBloc authBloc;

  LoginForm({
    Key key,
    @required this.loginBloc,
    @required this.authBloc,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwFocusNode = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwController = TextEditingController();

  LoginBloc get _loginBloc => widget.loginBloc;
  DeviceInfoPlugin _deviceInfo;
  bool _peek;
  String _error;
  String _userAgent;

  @override
  void initState() {
    super.initState();
    _peek = false;
    _deviceInfo = DeviceInfoPlugin();
    _getPlatformSpecificInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 30.00),
              child: SizedBox(width: 200, child: Logo()),
            ),
          ),
          BlocListener<LoginBloc, LoginState>(
            cubit: _loginBloc,
            listener: (context, state) {
              if (state is LoginFailure) {
                setState(() {
                  _error = 'Invalid email or password.';
                });
              }
            },
            child: Column(
              children: <Widget>[
                _buildEmailInput(),
                _buildPasswInput(),
                _buildSubmitButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return FormInput(
      controller: _emailController,
      focusNode: _emailFocusNode,
      label: 'Email address',
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      errorText: _error,
      onChanged: (_) {
        setState(() {
          _error = null;
        });
      },
      onFieldSubmitted: (_) => _passwFocusNode.requestFocus(),
    );
  }

  Widget _buildPasswInput() {
    return FormInput(
      controller: _passwController,
      focusNode: _passwFocusNode,
      label: 'Password',
      textInputAction: TextInputAction.go,
      obscureText: !_peek,
      suffixIcon: _buildPeekButton(),
      onFieldSubmitted: (_) => _submit(),
    );
  }

  Widget _buildPeekButton() {
    return IconButton(
      icon: _peek ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
      color: Colors.grey,
      onPressed: () {
        setState(() {
          _peek = !_peek;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 57,
      child: BlocBuilder<LoginBloc, LoginState>(
        cubit: _loginBloc,
        builder: (context, state) {
          return Button(
            busy: state is LoginLoading,
            child: Text('Sign in', style: TextStyle(color: Colors.white)),
            onPressed: _submit,
          );
        },
      ),
    );
  }

  void _getPlatformSpecificInformation() async {
    String agent;

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      agent = androidInfo.device;
    }

    if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      agent = iosInfo.name;
    }

    setState(() {
      _userAgent = agent;
    });
  }

  void _submit() {
    _emailFocusNode.unfocus();
    _passwFocusNode.unfocus();

    setState(() {
      _error = null;
    });

    _loginBloc.add(LoginButtonPressed(
      email: _emailController.text,
      password: _passwController.text,
      userAgent: _userAgent,
    ));
  }
}
