import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rakhaa/model/chopper/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals.dart' as Globals;

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
          SharedPreferences prefs = await SharedPreferences.getInstance();

          // print('Token: ${loginResponse.token}');
          // print('Name: ${loginResponse.data.name}');
          // print('Username: ${loginResponse.data.username}');
          // print('Image Url: ${loginResponse.data.imageUrl}');
          // print('Email: ${loginResponse.data.email}');
          // print('Phone: ${loginResponse.data.phone}');
          // print('Password: ${event.password}');
          await prefs.setString(Globals.token, loginResponse.token);
          await prefs.setString(Globals.name, loginResponse.data.name);
          await prefs.setString(Globals.username, loginResponse.data.username);
          await prefs.setString(Globals.imageUrl, loginResponse.data.imageUrl);
          await prefs.setString(Globals.email, loginResponse.data.email);
          await prefs.setString(Globals.phone, loginResponse.data.phone);
          await prefs.setString(Globals.password, event.password);
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
