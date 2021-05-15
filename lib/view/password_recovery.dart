import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'custom_show_dialog.dart';
import 'screen_util.dart';
import 'new_password.dart';
import 'code_verification_dialog.dart';

import '../bloc/forgot_password/forgot_password_bloc.dart';

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
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          if (state is VerifiedSate) {
            showDialog(
              builder: (context) => CustomAlertDialog(
                titlePadding: EdgeInsets.all(0.0),
                contentPadding: EdgeInsets.all(0.0),
                content: Container(
                  height: _screenUtil.setHeight(900),
                  width: _screenUtil.setWidth(800),
                  child: CodeVerificationDialog(
                    userId: state.userId,
                    onAuthenticated: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => NewPassword(
                                userId: state.userId,
                              )));
                    },
                  ),
                ),
              ),
              context: context,
            );
          } else if (state is NotVerifiedState) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: _screenUtil.setSp(50),
            );
          } else if (state is ErrorState) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: _screenUtil.setSp(50),
            );
          } else if (state is NoConnectivityState) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: _screenUtil.setSp(50),
            );
          }
        },
        child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
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
                                contentPadding:
                                    EdgeInsets.all(_screenUtil.setWidth(30)),
                                hintStyle: TextStyle(
                                  fontSize: _screenUtil.setSp(50),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      _screenUtil.setWidth(100)),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Map<String, dynamic> input;
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = new RegExp(pattern);

                              if (regExp.hasMatch(_usernameController.text)) {
                                input = {
                                  "username": "",
                                  "phone": "",
                                  "email": "${_usernameController.text}"
                                };
                              }
                              if (int.tryParse(_usernameController.text) !=
                                  null) {
                                input = {
                                  "username": "",
                                  "phone": "${_usernameController.text}",
                                  "email": ""
                                };
                              } else {
                                input = {
                                  "username": "${_usernameController.text}",
                                  "phone": "",
                                  "email": ""
                                };
                              }

                              BlocProvider.of<ForgotPasswordBloc>(context)
                                  .add(Sending(input));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: _screenUtil.setWidth(800),
                              height: _screenUtil.setHeight(150),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    _screenUtil.setWidth(80)),
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
                ),
                state is SendingState
                    ? Positioned(
                        top: 0.0,
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator()),
                            ],
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}
