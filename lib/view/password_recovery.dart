import 'package:flutter/material.dart';

import 'screen_util.dart';

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
              Container(
                alignment: Alignment.center,
                width: _screenUtil.setWidth(800),
                height: _screenUtil.setHeight(150),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_screenUtil.setWidth(80)),
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
