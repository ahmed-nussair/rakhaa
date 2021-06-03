import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom_show_dialog.dart';
import '../../screen_util.dart';
import '../../../bloc/profile/profile_bloc.dart';
import 'new_password_dialog.dart';
import 'package:image_picker/image_picker.dart';

import '../../../globals.dart' as Globals;

class DetailsPage extends StatefulWidget {
  final String name;
  final String imageUrl;
  final String email;
  final String phone;
  final String password;
  final String token;
  final Function onProfileImageUpdated;

  DetailsPage({
    @required this.name,
    @required this.imageUrl,
    @required this.email,
    @required this.phone,
    @required this.password,
    @required this.token,
    @required this.onProfileImageUpdated,
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
  bool _emailEditing;
  bool _phoneEditing;
  String _oldValue;

  File _image;
  String _imageSource;
  final picker = ImagePicker();

  final bloc = ProfileBloc();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _imageSource = pickedFile.path;
      }
    });
  }

  @override
  void initState() {
    _nameEditing = false;
    _emailEditing = false;
    _phoneEditing = false;
    _nameController.text = widget.name;
    _emailNameController.text = widget.email;
    _phoneNameController.text = widget.phone;
    _passwordNameController.text = widget.password;
    _oldValue = '';
    _imageSource = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String token = snapshot.data.getString(Globals.token);
          return BlocProvider(
            create: (_) => bloc,
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is ProfileUpdatedState) {
                  widget.onProfileImageUpdated();
                  snapshot.data.setString(
                      Globals.imageUrl, state.response.data.imageUrl);
                  snapshot.data
                      .setString(Globals.name, state.response.data.name);
                  snapshot.data
                      .setString(Globals.email, state.response.data.email);
                  snapshot.data
                      .setString(Globals.phone, state.response.data.phone);
                  _nameController.text = state.response.data.name;
                  _emailNameController.text = state.response.data.email;
                  _phoneNameController.text = state.response.data.phone;
                  Fluttertoast.showToast(
                    msg: 'تم تحديث البيانات بنجاح',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: _screenUtil.setSp(50),
                  );
                } else if (state is PasswordUpdatedState) {
                  Fluttertoast.showToast(
                    msg: 'تم تغيير كلمة المرور بنجاح',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: _screenUtil.setSp(50),
                  );
                }
              },
              child: BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      Column(
                        children: [
                          // the image and the fields
                          Expanded(
                            child: ListView(
                              children: [
                                Column(
                                  children: [
                                    // the profile image and the change image link.
                                    Column(
                                      children: [
                                        // the profile image
                                        _image == null
                                            ? CachedNetworkImage(
                                                imageUrl: widget.imageUrl,
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        Container(
                                                  width:
                                                      _screenUtil.setWidth(200),
                                                  height:
                                                      _screenUtil.setWidth(200),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover),
                                                  ),
                                                ),
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        CircularProgressIndicator(
                                                            value:
                                                                downloadProgress
                                                                    .progress),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/person.png'),
                                              )
                                            : CircleAvatar(
                                                backgroundColor:
                                                    Color(0x55000000),
                                                radius:
                                                    _screenUtil.setWidth(100),
                                                backgroundImage:
                                                    FileImage(_image),
                                              ),

                                        // change profile image link
                                        GestureDetector(
                                          onTap: () async {
                                            final pickedFile =
                                                await picker.getImage(
                                                    source:
                                                        ImageSource.gallery);

                                            setState(() {
                                              if (pickedFile != null) {
                                                _image = File(pickedFile.path);
                                                _imageSource = pickedFile.path;
                                              }
                                            });
                                            print(_imageSource);
                                          },
                                          child: Text(
                                            'تغيير الصورة',
                                            style: TextStyle(
                                              fontSize: _screenUtil.setSp(50),
                                              color: Colors.blueAccent,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // name
                                    Padding(
                                      padding: EdgeInsets.all(
                                          _screenUtil.setWidth(30)),
                                      child: Stack(
                                        children: [
                                          // the name field
                                          TextFormField(
                                            autofocus: _nameEditing,
                                            controller: _nameController,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: _screenUtil.setSp(50),
                                              color: _nameEditing
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.person,
                                                size: _screenUtil.setSp(50),
                                              ),
                                              enabled: _nameEditing,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        _screenUtil
                                                            .setWidth(50)),
                                              ),
                                            ),
                                          ),

                                          // the change name icon
                                          Positioned(
                                            top: 0.0,
                                            bottom: 0.0,
                                            left: 0.0,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  _screenUtil.setWidth(30)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _oldValue =
                                                      _nameController.text;
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
                                                                _nameEditing =
                                                                    false;
                                                              });
                                                              _nameController
                                                                      .text =
                                                                  _oldValue;
                                                            },
                                                            child: Icon(
                                                                Icons.cancel),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _nameEditing =
                                                                    false;
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons.check),
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
                                      padding: EdgeInsets.all(
                                          _screenUtil.setWidth(30)),
                                      child: Stack(
                                        children: [
                                          // email field
                                          TextFormField(
                                            controller: _emailNameController,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: _screenUtil.setSp(50),
                                              color: _emailEditing
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.email,
                                                size: _screenUtil.setSp(50),
                                              ),
                                              enabled: _emailEditing,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        _screenUtil
                                                            .setWidth(50)),
                                              ),
                                            ),
                                          ),

                                          // the change email icon
                                          Positioned(
                                            top: 0.0,
                                            bottom: 0.0,
                                            left: 0.0,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  _screenUtil.setWidth(30)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _oldValue =
                                                      _emailNameController.text;
                                                  setState(() {
                                                    _emailEditing = true;
                                                  });
                                                },
                                                child: _emailEditing
                                                    ? Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _emailEditing =
                                                                    false;
                                                              });
                                                              _emailNameController
                                                                      .text =
                                                                  _oldValue;
                                                            },
                                                            child: Icon(
                                                                Icons.cancel),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _emailEditing =
                                                                    false;
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons.check),
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

                                    // phone
                                    Padding(
                                      padding: EdgeInsets.all(
                                          _screenUtil.setWidth(30)),
                                      child: Stack(
                                        children: [
                                          // the phone field
                                          TextFormField(
                                            controller: _phoneNameController,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontSize: _screenUtil.setSp(50),
                                              color: _phoneEditing
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                Icons.phone,
                                                size: _screenUtil.setSp(50),
                                              ),
                                              enabled: _phoneEditing,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        _screenUtil
                                                            .setWidth(50)),
                                              ),
                                            ),
                                          ),

                                          // the change phone icon
                                          Positioned(
                                            top: 0.0,
                                            bottom: 0.0,
                                            left: 0.0,
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  _screenUtil.setWidth(30)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  _oldValue =
                                                      _phoneNameController.text;
                                                  setState(() {
                                                    _phoneEditing = true;
                                                  });
                                                },
                                                child: _phoneEditing
                                                    ? Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _phoneEditing =
                                                                    false;
                                                              });
                                                              _phoneNameController
                                                                      .text =
                                                                  _oldValue;
                                                            },
                                                            child: Icon(
                                                                Icons.cancel),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                _phoneEditing =
                                                                    false;
                                                              });
                                                            },
                                                            child: Icon(
                                                                Icons.check),
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

                                    // password
                                    Padding(
                                      padding: EdgeInsets.all(
                                          _screenUtil.setWidth(30)),
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
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        _screenUtil
                                                            .setWidth(50)),
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
                                                  builder: (context) =>
                                                      CustomAlertDialog(
                                                    titlePadding:
                                                        EdgeInsets.all(0.0),
                                                    contentPadding:
                                                        EdgeInsets.all(0.0),
                                                    content: Container(
                                                      height: _screenUtil
                                                          .setHeight(1000),
                                                      width: _screenUtil
                                                          .setWidth(800),
                                                      child: NewPasswordDialog(
                                                        onPasswordBeingUpdated:
                                                            (token, oldPassword,
                                                                newPassword) {
                                                          setState(() {
                                                            _passwordNameController
                                                                    .text =
                                                                newPassword;
                                                          });
                                                          bloc.add(
                                                              UpdatingPassword(
                                                                  token,
                                                                  oldPassword,
                                                                  newPassword));
                                                        },
                                                      ),
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
                                                    fontSize:
                                                        _screenUtil.setSp(50),
                                                    color: Colors.blueAccent,
                                                    decoration: TextDecoration
                                                        .underline,
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

                          // update profile button
                          Padding(
                            padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () async {
                                  BlocProvider.of<ProfileBloc>(context)
                                      .add(UpdatingProfile(
                                    token,
                                    _nameController.text,
                                    _emailNameController.text,
                                    _phoneNameController.text,
                                    image: _imageSource,
                                  ));
                                },
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
                      ),

                      // Circular Progress Indicator
                      state is UpdatingProfileState ||
                              state is UpdatingPasswordState
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
        return Container();
      },
    );
  }
}

