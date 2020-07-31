part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final String userAgent;

  const LoginButtonPressed({
    @required this.email,
    @required this.password,
    @required this.userAgent,
  });

  @override
  List<Object> get props => [email, password, userAgent];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password, user_agent: $userAgent }';
}
