part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}

class SigningUpState extends SignUpState {
  @override
  List<Object> get props => [];
}

class SuccessState extends SignUpState {
  final String message;

  SuccessState(this.message);

  @override
  List<Object> get props => [];
}

class FailedState extends SignUpState {
  final String message;

  FailedState(this.message);

  @override
  List<Object> get props => [message];
}

class ErrorState extends SignUpState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
