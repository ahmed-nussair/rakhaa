import 'package:flutter/material.dart';
import '../../custom_show_dialog.dart';
import '../../screen_util.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailNameController = TextEditingController();
  final TextEditingController _phoneNameController = TextEditingController();
  final TextEditingController _passwordNameController = TextEditingController();

  final _screenUtil = ScreenUtil();

  bool _firstNameEditing;
  bool _lastNameEditing;
  String _oldValue;

  @override
  void initState() {
    _firstNameEditing = false;
    _lastNameEditing = false;
    _firstNameController.text = 'أحمد';
    _lastNameController.text = 'نصير';
    _emailNameController.text = 'anussair@gamil.com';
    _phoneNameController.text = '+20 111 830 1953';
    _passwordNameController.text = '123';
    _oldValue = '';
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
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0x55000000),
                    radius: _screenUtil.setWidth(100),
                    backgroundImage: AssetImage('assets/person.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    child: Stack(
                      children: [
                        TextFormField(
                          autofocus: _firstNameEditing,
                          controller: _firstNameController,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color:
                                _firstNameEditing ? Colors.black : Colors.grey,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            enabled: _firstNameEditing,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  _screenUtil.setWidth(50)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: Padding(
                            padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                            child: GestureDetector(
                              onTap: () {
                                _oldValue = _firstNameController.text;
                                setState(() {
                                  _firstNameEditing = true;
                                });
                              },
                              child: _firstNameEditing
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _firstNameEditing = false;
                                            });
                                            _firstNameController.text =
                                                _oldValue;
                                          },
                                          child: Icon(Icons.cancel),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _firstNameEditing = false;
                                            });
                                          },
                                          child: Icon(Icons.check),
                                        ),
                                      ],
                                    )
                                  : Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // last name
                  Padding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: _lastNameController,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color:
                                _lastNameEditing ? Colors.black : Colors.grey,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.person),
                            enabled: _lastNameEditing,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  _screenUtil.setWidth(50)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: 0.0,
                          child: Padding(
                            padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                            child: GestureDetector(
                              onTap: () {
                                _oldValue = _lastNameController.text;
                                setState(() {
                                  _lastNameEditing = true;
                                });
                              },
                              child: _lastNameEditing
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _lastNameEditing = false;
                                            });
                                            _lastNameController.text =
                                                _oldValue;
                                          },
                                          child: Icon(Icons.cancel),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _lastNameEditing = false;
                                            });
                                          },
                                          child: Icon(Icons.check),
                                        ),
                                      ],
                                    )
                                  : Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // email
                  Padding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    child: TextFormField(
                      controller: _emailNameController,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.email),
                        enabled: false,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(_screenUtil.setWidth(50)),
                        ),
                      ),
                    ),
                  ),

                  // phone
                  Padding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    child: TextFormField(
                      controller: _phoneNameController,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.phone),
                        enabled: false,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(_screenUtil.setWidth(50)),
                        ),
                      ),
                    ),
                  ),

                  // password
                  Padding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    child: Stack(
                      children: [
                        TextFormField(
                          controller: _passwordNameController,
                          textAlign: TextAlign.end,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.lock),
                            enabled: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  _screenUtil.setWidth(50)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0.0,
                          bottom: 0.0,
                          left: _screenUtil.setWidth(50),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                child: CustomAlertDialog(
                                  titlePadding: EdgeInsets.all(0.0),
                                  contentPadding: EdgeInsets.all(0.0),
                                  content: Container(
                                    height: _screenUtil.setHeight(1000),
                                    width: _screenUtil.setWidth(800),
                                    child: NewPasswordDialog(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'تغيير كلمة المرور',
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(40),
                                  color: Colors.blueAccent,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              onPressed: () {},
              child: Text(
                'تحديث البيانات',
                style: TextStyle(
                  fontSize: _screenUtil.setSp(50),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
                child: TextFormField(
                  obscureText: true,
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
              ),
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                child: TextFormField(
                  obscureText: true,
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
              ),
              Padding(
                padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                child: TextFormField(
                  obscureText: true,
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
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(50)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
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
              RaisedButton(
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
