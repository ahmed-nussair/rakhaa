import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
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
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult != ConnectivityResult.wifi &&
          connectivityResult != ConnectivityResult.mobile) {
        yield NoConnectivityState(
            'من فضلك تأكد من اتصالك بالإنترنت قبل محاولة استرداد كلمة المرور.');
      } else {
        yield SendingState();

        final service = ForgotPasswordService.create();

        final response = await service.send(event.input);
        //print(response.bodyString);
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
      }
    } else {
      yield ForgotPasswordInitial();
    }
  }
}
