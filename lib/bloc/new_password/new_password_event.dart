part of 'new_password_bloc.dart';

abstract class NewPasswordEvent extends Equatable {
  const NewPasswordEvent();
}

class VerifyingPassword extends NewPasswordEvent {
  final String newPassword;
  final String confirmPassword;

  VerifyingPassword(this.newPassword, this.confirmPassword);

  @override
  List<Object> get props => [newPassword, confirmPassword];
}

class ChangingPassword extends NewPasswordEvent {
  final int userId;
  final String password;

  ChangingPassword(this.userId, this.password);

  @override
  List<Object> get props => [userId, password];
}
