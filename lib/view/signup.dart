import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'country_code.dart';
// import 'custom_show_dialog.dart';
import 'screen_util.dart';

import '../bloc/sign_up/sign_up_bloc.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final ScreenUtil _screenUtil = ScreenUtil();

  // final _firstNameController = TextEditingController();
  // final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  // String _countryCode;
  //
  // Gender _gender;

  @override
  void initState() {
    // _countryCode = '+20';
    // _gender = Gender.Male;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return BlocProvider(
      create: (_) => SignUpBloc(),
      child: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is SuccessState) {
            print(state.message);
          } else if (state is FailedState) {
            print(state.message);
          }
        },
        child: BlocBuilder<SignUpBloc, SignUpState>(
          builder: (context, state) {
            return Scaffold(
              body: Stack(
                children: [
                  ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(100)),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'تسجيل حساب جديد',
                            style: TextStyle(
                              fontSize: _screenUtil.setSp(80),
                            ),
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       right: _screenUtil.setWidth(30),
                      //       left: _screenUtil.setWidth(30),
                      //       top: _screenUtil.setWidth(20),
                      //       bottom: _screenUtil.setWidth(20)),
                      //   child: Row(
                      //     children: <Widget>[
                      //       Flexible(
                      //         child: _formField(
                      //           'اسم العائلة (إجباري)',
                      //           Icons.person,
                      //           controller: _lastNameController,
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: EdgeInsets.all(_screenUtil.setWidth(20)),
                      //       ),
                      //       Flexible(
                      //           child: _formField(
                      //         'الاسم الأول (إجباري)',
                      //         Icons.person,
                      //         controller: _firstNameController,
                      //       )),
                      //     ],
                      //   ),
                      // ),

                      // the name
                      Padding(
                        padding: EdgeInsets.only(
                            right: _screenUtil.setWidth(30),
                            left: _screenUtil.setWidth(30),
                            top: _screenUtil.setWidth(20),
                            bottom: _screenUtil.setWidth(20)),
                        child: _formField(
                          'الاسم بالكامل (إجباري)',
                          Icons.person,
                          controller: _userNameController,
                        ),
                      ),

                      // user name
                      Padding(
                        padding: EdgeInsets.only(
                            right: _screenUtil.setWidth(30),
                            left: _screenUtil.setWidth(30),
                            top: _screenUtil.setWidth(20),
                            bottom: _screenUtil.setWidth(20)),
                        child: _formField(
                          'اسم المستخدم (المعرف) (إجباري)',
                          Icons.person,
                          controller: _userNameController,
                        ),
                      ),

                      // //Gender
                      // Padding(
                      //   padding: EdgeInsets.only(
                      //       right: _screenUtil.setWidth(30),
                      //       left: _screenUtil.setWidth(30),
                      //       top: _screenUtil.setWidth(20),
                      //       bottom: _screenUtil.setWidth(20)),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Text(
                      //             'أنثى',
                      //             style: TextStyle(
                      //               fontSize: _screenUtil.setSp(40),
                      //             ),
                      //           ),
                      //           Radio(
                      //               value: Gender.Female,
                      //               groupValue: _gender,
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   _gender = value;
                      //                 });
                      //               }),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         width: _screenUtil.setWidth(50),
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text(
                      //             'ذكر',
                      //             style: TextStyle(
                      //               fontSize: _screenUtil.setSp(40),
                      //             ),
                      //           ),
                      //           Radio(
                      //               value: Gender.Male,
                      //               groupValue: _gender,
                      //               onChanged: (value) {
                      //                 setState(() {
                      //                   _gender = value;
                      //                 });
                      //               }),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         width: _screenUtil.setWidth(50),
                      //       ),
                      //       Row(
                      //         children: [
                      //           Text(
                      //             ':',
                      //             style: TextStyle(
                      //               fontSize: _screenUtil.setSp(40),
                      //             ),
                      //           ),
                      //           Text(
                      //             'النوع',
                      //             style: TextStyle(
                      //               fontSize: _screenUtil.setSp(40),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // email
                      Padding(
                        padding: EdgeInsets.only(
                            right: _screenUtil.setWidth(30),
                            left: _screenUtil.setWidth(30),
                            top: _screenUtil.setWidth(20),
                            bottom: _screenUtil.setWidth(20)),
                        child: _formField(
                          'البريد الإلكتروني (اختياري)',
                          Icons.email,
                          controller: _emailController,
                          inputType: TextInputType.emailAddress,
                        ),
                      ),

                      // Phone
                      Padding(
                        padding: EdgeInsets.only(
                            right: _screenUtil.setWidth(30),
                            left: _screenUtil.setWidth(30),
                            top: _screenUtil.setWidth(20),
                            bottom: _screenUtil.setWidth(20)),
                        child: Row(
                          children: [
                            // // country code
                            // Flexible(
                            //   flex: 1,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       showDialog(
                            //         builder: (context) => CustomAlertDialog(
                            //           titlePadding: EdgeInsets.all(0.0),
                            //           contentPadding: EdgeInsets.all(0.0),
                            //           content: CountryCode(
                            //             onCountryCodeSelected: (countryCode) {
                            //               setState(() {
                            //                 _countryCode = countryCode;
                            //               });
                            //             },
                            //           ),
                            //         ),
                            //         context: context,
                            //       );
                            //     },
                            //     child: Container(
                            //       alignment: Alignment.center,
                            //       width: _screenUtil.setWidth(800),
                            //       height: _screenUtil.setHeight(120),
                            //       padding:
                            //           EdgeInsets.all(_screenUtil.setHeight(25)),
                            //       decoration: BoxDecoration(
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(
                            //                   _screenUtil.setWidth(30))),
                            //           border: Border.all(
                            //             color: Color(0xffa6a6a6),
                            //             width: 1,
                            //           )),
                            //       child: Text(
                            //         _countryCode,
                            //         style: TextStyle(
                            //           fontSize: _screenUtil.setSp(40),
                            //           // color: Color(0xffd8cfcc),
                            //           color: Color(0xffa6a6a6),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            //
                            // // spacing
                            // Padding(
                            //   padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                            // ),
                            Flexible(
                              flex: 3,
                              child: _formField(
                                'الموبايل (إجباري)',
                                Icons.phone,
                                controller: _phoneController,
                                inputType: TextInputType.phone,
                              ),
                            )
                          ],
                        ),
                      ),

                      // password
                      Padding(
                        padding: EdgeInsets.only(
                            right: _screenUtil.setWidth(30),
                            left: _screenUtil.setWidth(30),
                            top: _screenUtil.setWidth(20),
                            bottom: _screenUtil.setWidth(20)),
                        child: _formField(
                          'كلمة المرور',
                          Icons.lock,
                          controller: _passwordController,
                          obscureText: true,
                        ),
                      ),

                      // confirm password
                      Padding(
                        padding: EdgeInsets.only(
                            right: _screenUtil.setWidth(30),
                            left: _screenUtil.setWidth(30),
                            top: _screenUtil.setWidth(20),
                            bottom: _screenUtil.setWidth(20)),
                        child: _formField(
                          'تأكيد كلمة المرور',
                          Icons.lock,
                          controller: _passwordConfirmController,
                          obscureText: true,
                        ),
                      ),

                      ListTile(
                        onTap: () {
                          BlocProvider.of<SignUpBloc>(context).add(SigningUp({
                            "first_name": "Ahmed",
                            "last_name": "Nussair",
                            "username": "ahmed_nussair",
                            "email": "anussair@gmail.com",
                            "phone": "00201118301953",
                            "gender": "Male",
                            "password": "123",
                          }));
                        },
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: _screenUtil.setHeight(150),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_screenUtil.setHeight(50))),
                              color: Colors.red,
                            ),
                            child: Text(
                              'تسجيل',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _screenUtil.setSp(50),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: _screenUtil.setHeight(50),
                    left: _screenUtil.setWidth(50),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: _screenUtil.setSp(70),
                      ),
                    ),
                  ),
                  state is SigningUpState
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _formField(String hintTitle, IconData icon,
      {@required final TextEditingController controller,
      final bool obscureText = false,
      final TextInputType inputType = TextInputType.text}) {
    return Stack(
      children: [
        Container(
          height: _screenUtil.setHeight(120),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(_screenUtil.setWidth(30))),
              ),
              hintText: hintTitle,
              contentPadding: EdgeInsets.only(
                  right: _screenUtil.setWidth(100),
                  top: _screenUtil.setHeight(28),
                  bottom: _screenUtil.setHeight(28)),
              hintStyle: TextStyle(
                // color: Color(0xffd8cfcc),
                fontSize: _screenUtil.setSp(40),
              ),
            ),
            keyboardType: inputType,
          ),
        ),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          right: 0.0,
          child: Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(28)),
            child: Icon(
              icon,
              // color: Color(0xffd9d9d9),
              color: Color(0xffa6a6a6),
              size: _screenUtil.setSp(40),
            ),
          ),
        ),
      ],
    );
  }
}

// enum Gender {
//   Male,
//   Female,
// }
