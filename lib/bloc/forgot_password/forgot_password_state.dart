part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class SendingState extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class SuccessSate extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

class FailureSate extends ForgotPasswordState {
  final String message;

  FailureSate(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorSate extends ForgotPasswordState {
  final String message;

  ErrorSate(this.message);

  @override
  List<Object> get props => [message];
}
