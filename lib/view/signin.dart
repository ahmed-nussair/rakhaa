import 'package:flutter/material.dart';
import 'package:rakhaa/view/password_recovery.dart';
import 'package:rakhaa/view/screen_util.dart';
import 'package:rakhaa/view/signup.dart';

import 'home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final ScreenUtil _screenUtil = ScreenUtil();

  // final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Scaffold(
      body: ListView(
        children: [
          // Title
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(80)),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(
                  fontSize: _screenUtil.setSp(100),
                ),
              ),
            ),
          ),

          // username / mobile number field
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(50)),
            child: TextFormField(
              controller: _usernameController,
              keyboardType: TextInputType.text,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(_screenUtil.setWidth(30)),
                hintText: 'اسم المستخدم أو رقم الموبايل',
                hintStyle: TextStyle(
                  fontSize: _screenUtil.setSp(50),
                ),
                suffixIcon: Icon(
                  Icons.person,
                  size: _screenUtil.setSp(50),
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(_screenUtil.setWidth(100)),
                ),
              ),
            ),
          ),

          // Password field
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(50)),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(_screenUtil.setWidth(30)),
                hintText: 'كلمة المرور',
                hintStyle: TextStyle(
                  fontSize: _screenUtil.setSp(50),
                ),
                suffixIcon: Icon(
                  Icons.lock,
                  size: _screenUtil.setSp(50),
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(_screenUtil.setWidth(100)),
                ),
              ),
            ),
          ),

          // Forgot your password link
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(50)),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PasswordRecovery()));
              },
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  'هل نسيت كلمة المرور؟',
                  style: TextStyle(
                    fontSize: _screenUtil.setSp(50),
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),

          // login button
          Padding(
            padding: EdgeInsets.only(
              left: _screenUtil.setWidth(50),
              right: _screenUtil.setWidth(50),
            ),
            child: Container(
              alignment: Alignment.center,
              // width: _screenUtil.setWidth(500),
              height: _screenUtil.setHeight(150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_screenUtil.setWidth(50)),
                color: Colors.red,
              ),
              child: Text(
                'تسجيل الدخول',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: _screenUtil.setSp(50),
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Sign up
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(30)),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'ليس لديك حساب؟ .. بإمكانك التسجيل',
                  style: TextStyle(
                    fontSize: _screenUtil.setSp(50),
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),

          // login via
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: _screenUtil.setHeight(3),
                  color: Color(0xff745d2a),
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  'تسجيل الدخول عن طريق',
                  style: TextStyle(
                      color: Color(0xff9b7448),
                      fontSize: _screenUtil.setSp(40)),
                  softWrap: false,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: _screenUtil.setHeight(3),
                  color: Color(0xff745d2a),
                ),
              ),
            ],
          ),

          // Facebook and gmail
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: _screenUtil.setWidth(90),
                  backgroundImage: AssetImage('assets/facebook_login.png'),
                ),
                Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                ),
                CircleAvatar(
                  radius: _screenUtil.setWidth(90),
                  backgroundImage: AssetImage('assets/google_login.png'),
                ),
              ],
            ),
          ),
        ],
      ),

      // login as a guest
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        },
        child: Container(
          padding: EdgeInsets.all(_screenUtil.setWidth(50)),
          color: Colors.red,
          child: Text(
            'الدخول كزائر',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: _screenUtil.setSp(50),
            ),
          ),
        ),
      ),
    );
  }
}
