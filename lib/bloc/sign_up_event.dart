part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SigningUp extends SignUpEvent {
  final Map<String, dynamic> input;

  SigningUp(this.input);

  @override
  List<Object> get props => [input];
}
