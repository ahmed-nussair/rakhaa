import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'custom_show_dialog.dart';
import 'screen_util.dart';
import 'new_password.dart';

class PasswordRecovery extends StatefulWidget {
  @override
  _PasswordRecoveryState createState() => _PasswordRecoveryState();
}

class _PasswordRecoveryState extends State<PasswordRecovery> {
  final ScreenUtil _screenUtil = ScreenUtil();

  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: _screenUtil.setHeight(50),
              ),
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(100)),
                child: Text(
                  'هل نسيت كلمة المرور؟',
                  style: TextStyle(
                    fontSize: _screenUtil.setSp(70),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(50)),
                child: TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    hintText: 'أدخل اسم المستخدم أو رقم الموبايل',
                    suffixIcon: Icon(Icons.person),
                    contentPadding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    hintStyle: TextStyle(
                      fontSize: _screenUtil.setSp(50),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(_screenUtil.setWidth(100)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    builder: (context) => CustomAlertDialog(
                      titlePadding: EdgeInsets.all(0.0),
                      contentPadding: EdgeInsets.all(0.0),
                      content: Container(
                        height: _screenUtil.setHeight(900),
                        width: _screenUtil.setWidth(800),
                        child: AuthenticationDialog(
                          onAuthenticated: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => NewPassword()));
                          },
                        ),
                      ),
                    ),
                    context: context,
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  width: _screenUtil.setWidth(800),
                  height: _screenUtil.setHeight(150),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(_screenUtil.setWidth(80)),
                    color: Colors.red,
                  ),
                  child: Text(
                    'أرسل لاستعادة كلمة المرور الخاصة بك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _screenUtil.setSp(50),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(40)),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(
                Icons.arrow_back,
                size: _screenUtil.setSp(80),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthenticationDialog extends StatefulWidget {
  final Function onAuthenticated;

  AuthenticationDialog({@required this.onAuthenticated});

  @override
  _AuthenticationDialogState createState() => _AuthenticationDialogState();
}

class _AuthenticationDialogState extends State<AuthenticationDialog> {
  final ScreenUtil _screenUtil = ScreenUtil();
  final TextEditingController _otpController = TextEditingController();

  String _status;

  @override
  void initState() {
    _status = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'قم بإدخال ال 4 أرقام المبينة في رسالة نصية على هاتفك',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _screenUtil.setSp(40),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                child: GestureDetector(
                  onTap: () {
                    Toast.show(
                      "سيتم إرسال كود جديد عبر رسالة نصية على هاتفك",
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'طلب إعادة إرسال كود التحقق',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(40),
                        color: Colors.blueAccent,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                child: TextFormField(
                  onTap: () {
                    setState(() {
                      _status = '';
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _status = '';
                    });
                  },
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  maxLength: 4,
                  controller: _otpController,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                    hintText: 'أدخل كود التحقق',
                    hintStyle: TextStyle(
                      fontSize: _screenUtil.setSp(40),
                    ),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(_screenUtil.setWidth(50)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    _status,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _screenUtil.setSp(40),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_otpController.text.isEmpty) {
                    setState(() {
                      _status = 'من فضلك أدخل الكود المرسل إليك عبر رسالة نصية';
                    });
                    return;
                  } else if (_otpController.text != '1234') {
                    setState(() {
                      _status = 'عفوًا الكود غير صحيح';
                    });
                    return;
                  } else {
                    Navigator.of(context).pop();
                    widget.onAuthenticated();
                  }
                },
                child: Text(
                  'تحقق من الكود',
                  style: TextStyle(
                    fontSize: _screenUtil.setSp(50),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'إلغاء',
                  style: TextStyle(
                    fontSize: _screenUtil.setSp(50),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}