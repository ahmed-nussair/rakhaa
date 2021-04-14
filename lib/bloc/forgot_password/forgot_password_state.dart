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

class VerifiedSate extends ForgotPasswordState {
  final int userId;

  VerifiedSate(this.userId);

  @override
  List<Object> get props => [];
}

class NotVerifiedState extends ForgotPasswordState {
  final String message;

  NotVerifiedState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorState extends ForgotPasswordState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
