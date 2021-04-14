import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/new_password/new_password_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'screen_util.dart';

class NewPassword extends StatefulWidget {
  final int userId;

  NewPassword({
    @required this.userId,
  });

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
    return BlocProvider(
      create: (_) => NewPasswordBloc(),
      child: BlocListener<NewPasswordBloc, NewPasswordState>(
        listener: (context, state) {
          if (state is PasswordVerifiedState) {
            BlocProvider.of<NewPasswordBloc>(context)
                .add(ChangingPassword(widget.userId, state.password));
          } else if (state is PasswordNotVerifiedState) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: _screenUtil.setSp(50),
            );
          } else if (state is SuccessfulState) {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: _screenUtil.setSp(50),
            );
          } else if (state is FailureState) {
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
        child: BlocBuilder<NewPasswordBloc, NewPasswordState>(
          builder: (context, state) {
            return Stack(
              children: [
                Scaffold(
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
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(50)),
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: true,
                          textAlign: TextAlign.end,
                          decoration: InputDecoration(
                            hintText: 'تأكيد كلمة المرور الجديدة',
                            suffixIcon: Icon(Icons.lock),
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
                          if (_newPasswordController.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "من فضلك أدخل كلمة المرور الجديدة",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: _screenUtil.setSp(50),
                            );
                            return;
                          }

                          if (_confirmPasswordController.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "من فضلك أعد إدخال كلمة المرور التي أدخلتها",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black54,
                              textColor: Colors.white,
                              fontSize: _screenUtil.setSp(50),
                            );
                            return;
                          }
                          BlocProvider.of<NewPasswordBloc>(context).add(
                              VerifyingPassword(_newPasswordController.text,
                                  _confirmPasswordController.text));
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
                ),
                state is ChangingPasswordState
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
