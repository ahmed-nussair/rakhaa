part of 'code_verification_bloc.dart';

abstract class CodeVerificationEvent extends Equatable {
  const CodeVerificationEvent();
}

class Idle extends CodeVerificationEvent {
  @override
  List<Object> get props => [];
}

class Verifying extends CodeVerificationEvent {
  final int userId;
  final String code;

  Verifying(this.userId, this.code);

  @override
  List<Object> get props => [
        code,
        userId,
      ];
}

class Resending extends CodeVerificationEvent {
  final int userId;

  Resending(
    this.userId,
  );

  @override
  List<Object> get props => [userId];
}
