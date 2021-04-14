import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/chopper/new_password_service.dart';

part 'new_password_event.dart';

part 'new_password_state.dart';

class NewPasswordBloc extends Bloc<NewPasswordEvent, NewPasswordState> {
  NewPasswordBloc() : super(NewPasswordInitial());

  @override
  Stream<NewPasswordState> mapEventToState(
    NewPasswordEvent event,
  ) async* {
    yield NewPasswordInitial();

    if (event is VerifyingPassword) {
      yield VerifyingPasswordState(event.newPassword, event.confirmPassword);

      if (event.newPassword == event.confirmPassword) {
        yield PasswordVerifiedState(event.newPassword);
      } else {
        yield PasswordNotVerifiedState(
            "كلمة السر غير مطابقة لكلمة السر التي أدخلتها");
      }
    } else if (event is ChangingPassword) {
      yield ChangingPasswordState();

      var service = NewPasswordService.create();
      var response = await service.changePassword({
        "userId": event.userId,
        "newPassword": event.password,
      });

      if (response.isSuccessful) {
        var newPasswordResponse = response.body;

        if (newPasswordResponse.result) {
          yield SuccessfulState("تم تغيير كلمة المرور بنجاح.");
        } else {
          yield FailureState(
              "يوجد مشكلة في تغيير كلمة المرور. من فضلك حاول مرة أخرى");
        }
      } else {
        yield FailureState("حدث خطأ .. من فضلك حاول في وقت آخر.");
      }
    }
  }
}
