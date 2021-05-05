import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rakhaa/view/screen_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals.dart' as Globals;

import 'home.dart';
import 'signin.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  final ScreenUtil _screenUtil = ScreenUtil();

  AnimationController _animationController;

  Animation _animation;

  startApp() async {
    return Timer(Duration(seconds: 2), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String token = prefs.getString(Globals.token) ?? '';
      String username = prefs.getString(Globals.username) ?? '';

      print('Token: $token');

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => token.isEmpty
                ? SignIn()
                : Home(
                    name: username,
                  )),
      );
    });
  }

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    _animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.linear,
        parent: _animationController,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          startApp();
        }
      });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: Image.asset('assets/logo.png'),
            );
          },
          child: Text(
            'Logo will be here',
            style: TextStyle(
              fontSize: _screenUtil.setSp(50),
            ),
          ),
        ),
      ),
    );
  }
}
