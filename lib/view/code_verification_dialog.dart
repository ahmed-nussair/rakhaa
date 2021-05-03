import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakhaa/bloc/code_verification/code_verification_bloc.dart';
import 'screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CodeVerificationDialog extends StatefulWidget {
  final int userId;
  final Function onAuthenticated;

  CodeVerificationDialog({
    @required this.onAuthenticated,
    @required this.userId,
  });

  @override
  _CodeVerificationDialogDialogState createState() =>
      _CodeVerificationDialogDialogState();
}

class _CodeVerificationDialogDialogState extends State<CodeVerificationDialog> {
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
    return BlocProvider(
      create: (_) => CodeVerificationBloc(),
      child: BlocListener<CodeVerificationBloc, CodeVerificationState>(
        listener: (context, state) {
          if (state is CodeSentState) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: _screenUtil.setSp(50),
            );
          } else if (state is CodeNotSentState) {
            Fluttertoast.showToast(
              msg: state.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: _screenUtil.setSp(50),
            );
          } else if (state is NoCodeEnteredState) {
            setState(() {
              _status = 'من فضلك أدخل الكود المرسل إليك عبر رسالة نصية';
            });
          } else if (state is CodeValidState) {
            Navigator.of(context).pop();
            widget.onAuthenticated();
          } else if (state is CodeNotValidState) {
            setState(() {
              _status = state.message;
            });
          } else {
            setState(() {
              _status = '';
            });
          }
        },
        child: BlocBuilder<CodeVerificationBloc, CodeVerificationState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      // instruction
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

                      // Resending code link
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<CodeVerificationBloc>(context)
                                .add(Resending(widget.userId));
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

                      // code field
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                        child: TextFormField(
                          onTap: () {
                            BlocProvider.of<CodeVerificationBloc>(context)
                                .add(Idle());
                          },
                          onChanged: (value) {
                            BlocProvider.of<CodeVerificationBloc>(context)
                                .add(Idle());
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
                              borderRadius: BorderRadius.circular(
                                  _screenUtil.setWidth(50)),
                            ),
                          ),
                        ),
                      ),

                      // status text
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

                // Buttons
                Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(50)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Code Verification Button
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CodeVerificationBloc>(context).add(
                              Verifying(widget.userId, _otpController.text));
                        },
                        child: Text(
                          'تحقق من الكود',
                          style: TextStyle(
                            fontSize: _screenUtil.setSp(50),
                          ),
                        ),
                      ),

                      // Cancel Button
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
          },
        ),
      ),
    );
  }
}
