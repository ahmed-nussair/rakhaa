import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
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
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult != ConnectivityResult.wifi &&
          connectivityResult != ConnectivityResult.mobile) {
        yield NoConnectivityState(
            'لا يوجد اتصال بالإنترنت، تأكد أولًا أنك متصل بالإنترنت.');
      } else {
        yield LoggingInState();

        String deviceId = '';
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

        if (Platform.isAndroid) {
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

          deviceId = androidInfo.androidId;
        } else if (Platform.isIOS) {
          IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
          deviceId = iosInfo.identifierForVendor;
          print('Running on ${iosInfo.utsname.machine}');
          print('Version ${iosInfo.utsname.version}');
          print('Release ${iosInfo.utsname.release}');
          print('Sysname ${iosInfo.utsname.sysname}');
          print('ID For Vendor ${iosInfo.identifierForVendor}');
          print('Localied Model ${iosInfo.localizedModel}');
        }

        final loginService = LoginService.create();

        final response = await loginService
            .login(event.username, event.password, deviceId: deviceId);
        // print(response.bodyString);
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
            await prefs.setString(
                Globals.username, loginResponse.data.username);
            await prefs.setString(
                Globals.imageUrl, loginResponse.data.imageUrl);
            await prefs.setString(Globals.email, loginResponse.data.email);
            await prefs.setString(Globals.phone, loginResponse.data.phone);
            await prefs.setString(Globals.password, event.password);
            await prefs.setString(Globals.deviceId, deviceId);
            yield SuccessState(
              name: loginResponse.data.name,
              email: loginResponse.data.email,
              imageUrl: loginResponse.data.imageUrl,
              password: event.password,
              phone: loginResponse.data.phone,
              token: loginResponse.token,
              username: loginResponse.data.username,
            );
          } else {
            yield FailedState(
                'اسم المستخدم ليس بصحيح أو كلمة المرور ليست بصحيحة');
          }
        } else {
          yield ErrorState('حدث خطأ .. يمكنك المحاولة لاحقًا');
        }
      }
    } else {
      yield LoginInitial();
    }
  }
}
