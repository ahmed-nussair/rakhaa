import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'custom_show_dialog.dart';
import 'screen_util.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final ScreenUtil _screenUtil = ScreenUtil();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: _screenUtil.setHeight(50),
          ),
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(100)),
            child: Text(
              'قم بإدخال كلمة مرور جديدة',
              style: TextStyle(
                fontSize: _screenUtil.setSp(70),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(50)),
            child: TextFormField(
              controller: _newPasswordController,
              obscureText: true,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: 'كلمة مرور جديدة',
                suffixIcon: Icon(Icons.lock),
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
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(50)),
            child: TextFormField(
              controller: _confirmPasswordController,
              obscureText: true,
              textAlign: TextAlign.end,
              decoration: InputDecoration(
                hintText: 'تأكيد كلمة المرور الجديدة',
                suffixIcon: Icon(Icons.lock),
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
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              width: _screenUtil.setWidth(800),
              height: _screenUtil.setHeight(150),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_screenUtil.setWidth(80)),
                color: Colors.red,
              ),
              child: Text(
                'حفظ كلمة المرورة الجديدة',
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
    );
  }
}
