part of 'code_verification_bloc.dart';

abstract class CodeVerificationState extends Equatable {
  const CodeVerificationState();
}

class CodeVerificationInitial extends CodeVerificationState {
  @override
  List<Object> get props => [];
}

class VerifyingCodeState extends CodeVerificationState {
  final String code;

  VerifyingCodeState(this.code);

  @override
  List<Object> get props => [code];
}

class CodeValidState extends CodeVerificationState {
  @override
  List<Object> get props => [];
}

class CodeNotValidState extends CodeVerificationState {
  final String message;

  CodeNotValidState(this.message);

  @override
  List<Object> get props => [message];
}

class ResendingCodeState extends CodeVerificationState {
  @override
  List<Object> get props => [];
}

class CodeSentState extends CodeVerificationState {
  final String message;
  final int statusColorCode;

  CodeSentState(this.message, this.statusColorCode);

  @override
  List<Object> get props => [message, statusColorCode];
}

class CodeNotSentState extends CodeVerificationState {
  final String message;
  final int statusColorCode;

  CodeNotSentState(this.message, this.statusColorCode);

  @override
  List<Object> get props => [message, statusColorCode];
}

class ErrorState extends CodeVerificationState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class NoCodeEnteredState extends CodeVerificationState {
  final String message;

  NoCodeEnteredState(this.message);

  @override
  List<Object> get props => [message];
}
