import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/chopper/code_verification_service.dart';
import '../../model/chopper/code_resending_service.dart';

part 'code_verification_event.dart';

part 'code_verification_state.dart';

class CodeVerificationBloc
    extends Bloc<CodeVerificationEvent, CodeVerificationState> {
  CodeVerificationBloc() : super(CodeVerificationInitial());

  @override
  Stream<CodeVerificationState> mapEventToState(
    CodeVerificationEvent event,
  ) async* {
    yield CodeVerificationInitial();

    if (event is Verifying) {
      yield VerifyingCodeState(event.code);

      if (event.code.isNotEmpty) {
        final service = CodeVerificationService.create();

        final response = await service.verify({
          'userId': event.userId,
          'code': event.code,
        });

        if (response.isSuccessful) {
          final verificationResponse = response.body;

          if (verificationResponse.result) {
            yield CodeValidState();
          } else {
            yield CodeNotValidState("عفوًا الكود غير صحيح.");
          }
        } else {
          yield ErrorState("حدث خطأ .. يمكنك المحاولة في وقت آخر.");
        }
      } else {
        yield NoCodeEnteredState(
            "من فضلك أدخل الكود المرسل لك عبر رسالة نصية على هاتفك.");
      }
    } else if (event is Resending) {
      yield ResendingCodeState();

      final service = CodeResendingService.create();

      final response = await service.resend(event.userId);

      if (response.isSuccessful) {
        final resendingResponse = response.body;

        if (resendingResponse.result) {
          yield CodeSentState(
              "تم إرسال كود جديد عبر رسالة نصية على هاتفك", 0xFF008000);
        } else {
          yield CodeNotSentState(
              "فشل في محاولة إرسال كود جديد .. من فضلك حاول مرة أخرى.",
              0xFFFF0000);
        }
      } else {
        yield ErrorState("حدث خطأ .. يمكنك المحاولة في وقت آخر.");
      }
    } else if (event is Idle) {
      yield CodeVerificationInitial();
    }
  }
}
