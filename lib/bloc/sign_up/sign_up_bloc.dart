import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rakhaa/model/chopper/signup_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial());

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    yield SignUpInitial();

    if (event is SigningUp) {
      yield SigningUpState();

      final signUpService = SignUpService.create();

      final response = await signUpService.signUp(event.input);

      if (response.isSuccessful) {
        final signUpResponse = response.body;

        if (signUpResponse.result) {
          yield SuccessState(signUpResponse.message);
        } else {
          yield FailedState('تم التسجيل بنجاح');
        }
      } else {
        yield ErrorState('حدث خطأ .. يمكنك محاولة التسجيل في وقت آخر.');
      }
    } else {
      yield SignUpInitial();
    }
  }
}
