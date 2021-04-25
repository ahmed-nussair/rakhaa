import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

import 'view/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(App());
}

class App extends StatelessWidget {
  _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');
      print('Device ID ${androidInfo.id}');
      print('Android ID ${androidInfo.androidId}');
      print('Device ${androidInfo.device}');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');
      print('Version ${iosInfo.utsname.version}');
      print('Release ${iosInfo.utsname.release}');
      print('Sysname ${iosInfo.utsname.sysname}');
      print('ID For Vendor ${iosInfo.identifierForVendor}');
      print('Localied Model ${iosInfo.localizedModel}');
    }
  }

  @override
  Widget build(BuildContext context) {
    _getDeviceInfo();

    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;

      print('App Name: $appName');
      print('Package Name: $packageName');
      print('Version: $version');
      print('Build Number: $buildNumber');
    });
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
