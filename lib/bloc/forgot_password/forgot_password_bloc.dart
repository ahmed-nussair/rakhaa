import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/chopper/forgot_password_service.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    yield ForgotPasswordInitial();

    if (event is Sending) {
      yield SendingState();

      final service = ForgotPasswordService.create();

      final response = await service.send(event.input);

      if (response.isSuccessful) {
        final verificationResponse = response.body;

        if (verificationResponse.result) {
          yield VerifiedSate(verificationResponse.userId);
        } else {
          yield NotVerifiedState("عفوًا .. هذا المستخدم ليس مسجلًا.");
        }
      } else {
        yield ErrorState("حدث خطأ .. يمكنك المحاولة في وقت آخر.");
      }
    } else {
      yield ForgotPasswordInitial();
    }
  }
}
