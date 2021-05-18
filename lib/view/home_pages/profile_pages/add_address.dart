import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../screen_util.dart';

import 'governorates_cities_widget.dart';

class AddAddress extends StatefulWidget {
  final String token;
  final Function(Map<String, dynamic>) onAddressAdded;

  AddAddress({@required this.token, @required this.onAddressAdded});

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final ScreenUtil _screenUtil = ScreenUtil();

  final TextEditingController _buildingNoController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _moreDescriptionController =
      TextEditingController();

  bool _containingFloor;
  bool _containingDepartment;

  int _governorateId;
  int _cityId;

  int floor;
  int department;

  @override
  void initState() {
    _containingFloor = false;
    _containingDepartment = false;
    _governorateId = 0;
    _cityId = 0;
    floor = -1;
    department = -1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _screenUtil.setWidth(1000),
      height: _screenUtil.setHeight(2000),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ScreenUtil().setWidth(50)),
                topRight: Radius.circular(ScreenUtil().setWidth(50)),
              ),
              color: Color(0xff9b7448),
            ),
            child: Text(
              'إضافة عنوان جديد',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(50),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                  child: _formField('رقم العمارة / المبنى / المنشأة', null,
                      controller: _buildingNoController,
                      inputType: TextInputType.text,
                      maxLines: 1),
                ),
                Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                  child: _formField('اسم الشارع بالتفصيل', null,
                      controller: _streetController,
                      inputType: TextInputType.multiline,
                      maxLines: 2),
                ),

                Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                  child: _formField(
                      'تفاصيل أكثر للعنوان (بجانب المحل الفلاني ، أمام مطعم معين ، إلخ)',
                      null,
                      controller: _moreDescriptionController,
                      inputType: TextInputType.multiline,
                      maxLines: 3),
                ),

                Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: _formField(
                          'أدخل رقم الدور (أدخل 0 للدور الأرضي)',
                          null,
                          controller: _floorController,
                          inputType: TextInputType.numberWithOptions(
                            decimal: false,
                            signed: false,
                          ),
                          enabled: _containingFloor,
                        ),
                      ),
                      Text(
                        'رقم الدور',
                        style: TextStyle(
                          fontSize: _screenUtil.setSp(40),
                        ),
                      ),
                      Checkbox(
                        value: _containingFloor,
                        onChanged: (value) {
                          setState(() {
                            _containingFloor = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: _formField(
                          'أدخل رقم الشقة',
                          null,
                          controller: _departmentController,
                          inputType: TextInputType.numberWithOptions(
                            signed: false,
                            decimal: false,
                          ),
                          enabled: _containingDepartment,
                        ),
                      ),
                      Text(
                        'رقم الشقة',
                        style: TextStyle(
                          fontSize: _screenUtil.setSp(40),
                        ),
                      ),
                      Checkbox(
                        value: _containingDepartment,
                        onChanged: (value) {
                          setState(() {
                            _containingDepartment = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                  child: GovernoratesCitiesWidget(
                    onGovernorateSelected: (governorateId) {
                      setState(() {
                        _governorateId = governorateId;
                      });
                      // print('Governorate ID set to: $_governorateId');
                    },
                    onCitySelected: (cityId) {
                      setState(() {
                        _cityId = cityId;
                      });
                      // print('City ID set to: $_cityId');
                    },
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Flexible(
                //         child: ElevatedButton(
                //           // color: Color(0xff9b7448),
                //           onPressed: () {
                //             Navigator.of(context).pop();
                //           },
                //           child: Text(
                //             'إلغاء',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: _screenUtil.setSp(50),
                //             ),
                //           ),
                //         ),
                //       ),
                //       SizedBox(
                //         width: _screenUtil.setWidth(30),
                //       ),
                //       Flexible(
                //         child: ElevatedButton(
                //           // color: Color(0xff9b7448),
                //           onPressed: () {
                //
                //             if(_buildingNoController.text.isEmpty) {
                //               Fluttertoast.showToast(
                //                 msg: 'من فضلك أدخل رقم العمارة / المبنى / المنشأة',
                //                 toastLength: Toast.LENGTH_LONG,
                //                 gravity: ToastGravity.BOTTOM,
                //                 timeInSecForIosWeb: 1,
                //                 backgroundColor: Colors.black54,
                //                 textColor: Colors.white,
                //                 fontSize: _screenUtil.setSp(50),
                //               );
                //               return;
                //             }
                //
                //             if(_streetController.text.isEmpty) {
                //               Fluttertoast.showToast(
                //                 msg: 'من فضلك أدخل اسم الشارع بالتفصيل',
                //                 toastLength: Toast.LENGTH_LONG,
                //                 gravity: ToastGravity.BOTTOM,
                //                 timeInSecForIosWeb: 1,
                //                 backgroundColor: Colors.black54,
                //                 textColor: Colors.white,
                //                 fontSize: _screenUtil.setSp(50),
                //               );
                //               return;
                //             }
                //
                //             if(_containingFloor) {
                //               if(_floorController.text.isEmpty) {
                //                 Fluttertoast.showToast(
                //                   msg: 'من فضلك أدخل الدور',
                //                   toastLength: Toast.LENGTH_LONG,
                //                   gravity: ToastGravity.BOTTOM,
                //                   timeInSecForIosWeb: 1,
                //                   backgroundColor: Colors.black54,
                //                   textColor: Colors.white,
                //                   fontSize: _screenUtil.setSp(50),
                //                 );
                //                 return;
                //               }
                //             }
                //
                //             if(_containingDepartment) {
                //               if(_departmentController.text.isEmpty) {
                //                 Fluttertoast.showToast(
                //                   msg: 'من فضلك أدخل رقم الشقة',
                //                   toastLength: Toast.LENGTH_LONG,
                //                   gravity: ToastGravity.BOTTOM,
                //                   timeInSecForIosWeb: 1,
                //                   backgroundColor: Colors.black54,
                //                   textColor: Colors.white,
                //                   fontSize: _screenUtil.setSp(50),
                //                 );
                //                 return;
                //               }
                //             }
                //
                //             if(_governorateId <= 0) {
                //               Fluttertoast.showToast(
                //                 msg: 'من فضلك اختر المحافظة',
                //                 toastLength: Toast.LENGTH_LONG,
                //                 gravity: ToastGravity.BOTTOM,
                //                 timeInSecForIosWeb: 1,
                //                 backgroundColor: Colors.black54,
                //                 textColor: Colors.white,
                //                 fontSize: _screenUtil.setSp(50),
                //               );
                //               return;
                //             }
                //
                //             if(_cityId <= 0) {
                //               Fluttertoast.showToast(
                //                 msg: 'من فضلك اختر الحي أو المركز التابع للمحافظة',
                //                 toastLength: Toast.LENGTH_LONG,
                //                 gravity: ToastGravity.BOTTOM,
                //                 timeInSecForIosWeb: 1,
                //                 backgroundColor: Colors.black54,
                //                 textColor: Colors.white,
                //                 fontSize: _screenUtil.setSp(50),
                //               );
                //               return;
                //             }
                //
                //
                //             Map<String, dynamic> data = {
                //               'token': widget.token,
                //               'buildingNo': _buildingNoController.text,
                //               'street': _streetController.text,
                //               'floor': floor,
                //               'department': department,
                //               'moreDescription': _moreDescriptionController.text,
                //               'governorateId': _governorateId,
                //               'cityId': _cityId,
                //             };
                //             widget.onAddressAdded(data);
                //             Navigator.of(context).pop();
                //           },
                //           child: Text(
                //             'أضف',
                //             textAlign: TextAlign.center,
                //             style: TextStyle(
                //               color: Colors.white,
                //               fontSize: _screenUtil.setSp(50),
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ElevatedButton(
                  // color: Color(0xff9b7448),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'إلغاء',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenUtil.setSp(50),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: _screenUtil.setWidth(30),
              ),
              Flexible(
                child: ElevatedButton(
                  // color: Color(0xff9b7448),
                  onPressed: () {
                    if (_buildingNoController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'من فضلك أدخل رقم العمارة / المبنى / المنشأة',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: _screenUtil.setSp(50),
                      );
                      return;
                    }

                    if (_streetController.text.isEmpty) {
                      Fluttertoast.showToast(
                        msg: 'من فضلك أدخل اسم الشارع بالتفصيل',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: _screenUtil.setSp(50),
                      );
                      return;
                    }

                    if (_containingFloor) {
                      if (_floorController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'من فضلك أدخل الدور',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black54,
                          textColor: Colors.white,
                          fontSize: _screenUtil.setSp(50),
                        );
                        return;
                      }
                    }

                    if (_containingDepartment) {
                      if (_departmentController.text.isEmpty) {
                        Fluttertoast.showToast(
                          msg: 'من فضلك أدخل رقم الشقة',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black54,
                          textColor: Colors.white,
                          fontSize: _screenUtil.setSp(50),
                        );
                        return;
                      }
                    }

                    if (_governorateId <= 0) {
                      Fluttertoast.showToast(
                        msg: 'من فضلك اختر المحافظة',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: _screenUtil.setSp(50),
                      );
                      return;
                    }

                    if (_cityId <= 0) {
                      Fluttertoast.showToast(
                        msg: 'من فضلك اختر الحي أو المركز التابع للمحافظة',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: _screenUtil.setSp(50),
                      );
                      return;
                    }

                    Map<String, dynamic> data = {
                      'token': widget.token,
                      'buildingNo': _buildingNoController.text,
                      'street': _streetController.text,
                      'floor': floor,
                      'department': department,
                      'moreDescription': _moreDescriptionController.text,
                      'governorateId': _governorateId,
                      'cityId': _cityId,
                    };
                    widget.onAddressAdded(data);
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'أضف',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: _screenUtil.setSp(50),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _formField(
    String hintTitle,
    IconData icon, {
    @required final TextEditingController controller,
    final bool obscureText = false,
    final TextInputType inputType = TextInputType.text,
    final int maxLines = 1,
    final bool enabled = true,
  }) {
    return Stack(
      children: [
        Container(
          child: TextFormField(
            enabled: enabled,
            textAlign: TextAlign.end,
            controller: controller,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(
              fillColor: Color(0xfff4f4f8),
              filled: true,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(_screenUtil.setWidth(30))),
                borderSide: BorderSide.none,
              ),
              hintText: hintTitle,
              contentPadding: EdgeInsets.only(
                  right: icon == null
                      ? _screenUtil.setWidth(28)
                      : _screenUtil.setWidth(100),
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
        icon != null
            ? Positioned(
                top: 0.0,
                bottom: 0.0,
                left: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(28)),
                  child: Icon(
                    icon,
                    color: Color(0xffd9d9d9),
                    size: _screenUtil.setSp(40),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
