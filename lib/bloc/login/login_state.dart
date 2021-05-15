part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoggingInState extends LoginState {
  @override
  List<Object> get props => [];
}

class SuccessState extends LoginState {
  final String token;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String password;
  final String imageUrl;

  SuccessState({
    this.name,
    this.imageUrl,
    this.token,
    this.phone,
    this.password,
    this.email,
    this.username,
  });

  @override
  List<Object> get props =>
      [token, name, username, email, phone, password, imageUrl];
}

class FailedState extends LoginState {
  final String message;

  FailedState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorState extends LoginState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NoConnectivityState extends LoginState {
  final String message;

  NoConnectivityState(this.message);

  @override
  List<Object> get props => [message];
}
