import 'package:flutter/material.dart';

import '../../app_icons.dart';
import '../../screen_util.dart';

class NewPasswordDialog extends StatefulWidget {
  @override
  _NewPasswordDialogState createState() => _NewPasswordDialogState();
}

class _NewPasswordDialogState extends State<NewPasswordDialog> {
  final ScreenUtil _screenUtil = ScreenUtil();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _newPasswordConfirmController =
      TextEditingController();

  bool _currentPasswordShown;
  bool _newPasswordShown;
  bool _newPasswordConfirmShown;

  @override
  void initState() {
    _currentPasswordShown = false;
    _newPasswordShown = false;
    _newPasswordConfirmShown = false;
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
              // current password.
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                child: Stack(
                  children: [
                    TextFormField(
                      obscureText: _currentPasswordShown ? false : true,
                      textAlign: TextAlign.end,
                      controller: _oldPasswordController,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: 'اكتب كلمة المرور الحالية',
                        hintStyle: TextStyle(
                          fontSize: _screenUtil.setSp(40),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(_screenUtil.setWidth(50)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      bottom: 0.0,
                      left: _screenUtil.setWidth(50),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentPasswordShown =
                                _currentPasswordShown ? false : true;
                          });
                        },
                        child: Container(
                          height: _screenUtil.setHeight(120),
                          alignment: Alignment.center,
                          child: Icon(
                            _currentPasswordShown
                                ? AppIcons.eye_slash
                                : AppIcons.eye,
                            size: _screenUtil.setSp(50),
                            color: Color(0xff707070),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // new password.
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                child: Stack(
                  children: [
                    TextFormField(
                      obscureText: _newPasswordShown ? false : true,
                      textAlign: TextAlign.end,
                      controller: _newPasswordController,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: 'اكتب كلمة المرور الجديدة',
                        hintStyle: TextStyle(
                          fontSize: _screenUtil.setSp(40),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(_screenUtil.setWidth(50)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      bottom: 0.0,
                      left: _screenUtil.setWidth(50),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _newPasswordShown =
                                _newPasswordShown ? false : true;
                          });
                        },
                        child: Container(
                          height: _screenUtil.setHeight(120),
                          alignment: Alignment.center,
                          child: Icon(
                            _newPasswordShown
                                ? AppIcons.eye_slash
                                : AppIcons.eye,
                            size: _screenUtil.setSp(50),
                            color: Color(0xff707070),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // confirm new password.
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                child: Stack(
                  children: [
                    TextFormField(
                      obscureText: _newPasswordConfirmShown ? false : true,
                      textAlign: TextAlign.end,
                      controller: _newPasswordConfirmController,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        hintText: 'أعد كتابة كلمة المرور الجديدة',
                        hintStyle: TextStyle(
                          fontSize: _screenUtil.setSp(40),
                        ),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(_screenUtil.setWidth(50)),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.0,
                      bottom: 0.0,
                      left: _screenUtil.setWidth(50),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _newPasswordConfirmShown =
                                _newPasswordConfirmShown ? false : true;
                          });
                        },
                        child: Container(
                          height: _screenUtil.setHeight(120),
                          alignment: Alignment.center,
                          child: Icon(
                            _newPasswordConfirmShown
                                ? AppIcons.eye_slash
                                : AppIcons.eye,
                            size: _screenUtil.setSp(50),
                            color: Color(0xff707070),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // confirm the new password or cancel
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'حدّث كلمة المرور',
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
