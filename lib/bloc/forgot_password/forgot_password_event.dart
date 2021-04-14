part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class Sending extends ForgotPasswordEvent {
  final Map<String, dynamic> input;

  Sending(this.input);

  @override
  List<Object> get props => [input];
}
