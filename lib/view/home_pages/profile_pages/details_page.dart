import 'package:flutter/material.dart';
import '../../custom_show_dialog.dart';
import '../../screen_util.dart';
import 'new_password_dialog.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final String password;
  final String token;

  DetailsPage({
    @required this.name,
    @required this.imageUrl,
    @required this.email,
    @required this.phone,
    @required this.password,
    @required this.token,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailNameController = TextEditingController();
  final TextEditingController _phoneNameController = TextEditingController();
  final TextEditingController _passwordNameController = TextEditingController();

  final _screenUtil = ScreenUtil();

  bool _nameEditing;
  String _oldValue;

  @override
  void initState() {
    _nameEditing = false;
    _nameController.text = widget.name;
    _emailNameController.text = widget.email;
    _phoneNameController.text = widget.phone;
    _passwordNameController.text = widget.password;
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
                    backgroundImage: widget.imageUrl.isEmpty
                        ? AssetImage('assets/person.png')
                        : NetworkImage(widget.imageUrl),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    child: Stack(
                      children: [
                        TextFormField(
                          autofocus: _nameEditing,
                          controller: _nameController,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontSize: _screenUtil.setSp(50),
                            color: _nameEditing ? Colors.black : Colors.grey,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.person,
                              size: _screenUtil.setSp(50),
                            ),
                            enabled: _nameEditing,
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
                                _oldValue = _nameController.text;
                                setState(() {
                                  _nameEditing = true;
                                });
                              },
                              child: _nameEditing
                                  ? Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _nameEditing = false;
                                            });
                                            _nameController.text = _oldValue;
                                          },
                                          child: Icon(Icons.cancel),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _nameEditing = false;
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
                        fontSize: _screenUtil.setSp(50),
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.email,
                          size: _screenUtil.setSp(50),
                        ),
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
                        fontSize: _screenUtil.setSp(50),
                        color: Colors.grey,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.phone,
                          size: _screenUtil.setSp(50),
                        ),
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
                            fontSize: _screenUtil.setSp(50),
                            color: Colors.grey,
                          ),
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.lock,
                              size: _screenUtil.setSp(50),
                            ),
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
                                builder: (context) => CustomAlertDialog(
                                  titlePadding: EdgeInsets.all(0.0),
                                  contentPadding: EdgeInsets.all(0.0),
                                  content: Container(
                                    height: _screenUtil.setHeight(1000),
                                    width: _screenUtil.setWidth(800),
                                    child: NewPasswordDialog(),
                                  ),
                                ),
                                context: context,
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'تغيير كلمة المرور',
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(50),
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
            child: ElevatedButton(
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

