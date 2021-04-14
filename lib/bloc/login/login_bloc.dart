import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rakhaa/model/chopper/login_service.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    yield LoginInitial();

    if (event is LoggingIn) {
      yield LoggingInState();

      final loginService = LoginService.create();

      final response = await loginService.login(event.username, event.password);

      if (response.isSuccessful) {
        final loginResponse = response.body;

        if (loginResponse.result) {
          yield SuccessState();
        } else {
          yield FailedState(
              'اسم المستخدم ليس بصحيح أو كلمة المرور ليست بصحيحة');
        }
      } else {
        yield ErrorState('حدث خطأ .. يمكنك المحاولة لاحقًا');
      }
    } else {
      yield LoginInitial();
    }
  }
}
