part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthEvent {
  final String token;
  final User user;

  LoggedIn({
    @required this.token,
    @required this.user,
  });

  @override
  List<Object> get props => [token, user];

  @override
  String toString() => 'LoggedIn { token: $token, user: $user }';
}

class LoggedOut extends AuthEvent {
  @override
  String toString() => 'LoggedOut';
}
