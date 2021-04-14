part of 'new_password_bloc.dart';

abstract class NewPasswordState extends Equatable {
  const NewPasswordState();
}

class NewPasswordInitial extends NewPasswordState {
  @override
  List<Object> get props => [];
}

class VerifyingPasswordState extends NewPasswordState {
  final String newPassword;
  final String confirmPassword;

  VerifyingPasswordState(this.newPassword, this.confirmPassword);

  @override
  List<Object> get props => [newPassword, confirmPassword];
}

class PasswordVerifiedState extends NewPasswordState {
  final String password;

  PasswordVerifiedState(this.password);

  @override
  List<Object> get props => [password];
}

class PasswordNotVerifiedState extends NewPasswordState {
  final String message;

  PasswordNotVerifiedState(this.message);

  @override
  List<Object> get props => [message];
}

class ChangingPasswordState extends NewPasswordState {
  @override
  List<Object> get props => [];
}

class SuccessfulState extends NewPasswordState {
  final String message;

  SuccessfulState(this.message);

  @override
  List<Object> get props => [message];
}

class FailureState extends NewPasswordState {
  final String message;

  FailureState(this.message);

  @override
  List<Object> get props => [message];
}
