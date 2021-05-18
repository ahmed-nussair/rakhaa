import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../screen_util.dart';

import 'governorates_cities_widget.dart';

class NewAddress extends StatefulWidget {
  final String token;
  final Function(Map<String, dynamic>) onAddressAdded;

  NewAddress({@required this.token, @required this.onAddressAdded});

  @override
  _NewAddressState createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
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

  String _governorateName;
  String _cityName;

  int floor;
  int department;

  Map<String, dynamic> _data;

  @override
  void initState() {
    _containingFloor = false;
    _containingDepartment = false;
    _governorateId = 0;
    _cityId = 0;
    _governorateName = '';
    _cityName = '';
    floor = -1;
    department = -1;
    _data = {
      'id': 0,
      'buildingNo': '',
      'street': '',
      'governorate': {
        'id': 0,
        'name': '',
      },
      'city': {
        'id': 0,
        'name': '',
      },
      'floor': -1,
      'department': -1,
      'moreDescription': '',
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: _formField('رقم العمارة / المبنى / المنشأة', null,
              addressField: 'buildingNo',
              addressFieldValue: _buildingNoController.text,
              controller: _buildingNoController,
              inputType: TextInputType.text,
              maxLines: 1),
        ),
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: _formField('اسم الشارع بالتفصيل', null,
              addressField: 'street',
              addressFieldValue: _streetController.text,
              controller: _streetController,
              inputType: TextInputType.multiline,
              maxLines: 2),
        ),

        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: _formField(
              'تفاصيل أكثر للعنوان (بجانب المحل الفلاني ، أمام مطعم معين ، إلخ)',
              null,
              addressField: 'moreDescription',
              addressFieldValue: _moreDescriptionController.text,
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
                  addressField: 'floor',
                  addressFieldValue: _floorController.text.isNotEmpty
                      ? int.parse(_floorController.text)
                      : -1,
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
                    _data['floor'] = value
                        ? _floorController.text.isEmpty
                            ? -2
                            : int.parse(_floorController.text)
                        : -1;
                  });
                  widget.onAddressAdded(_data);
                },
              ),
            ],
          ),
        ),

        // Department
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
                  addressField: 'department',
                  addressFieldValue: _departmentController.text.isNotEmpty
                      ? int.parse(_departmentController.text)
                      : -1,
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
                    _data['department'] = value
                        ? _departmentController.text.isEmpty
                            ? -2
                            : int.parse(_departmentController.text)
                        : -1;
                  });
                  widget.onAddressAdded(_data);
                },
              ),
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: GovernoratesCitiesWidget(
            onGovernorateSelected: (governorateId, governorateName) {
              setState(() {
                _governorateId = governorateId;
                _governorateName = governorateName;
                _data['governorate']['id'] = _governorateId;
                _data['governorate']['name'] = _governorateName;
              });
              // print(_data);
              widget.onAddressAdded(_data);
            },
            onCitySelected: (cityId, cityName) {
              setState(() {
                _cityId = cityId;
                _cityName = cityName;
                _data['city']['id'] = _cityId;
                _data['city']['name'] = _cityName;
              });
              // print(_data);
              widget.onAddressAdded(_data);
            },
          ),
        ),
      ],
    );
  }

  Widget _formField(
    String hintTitle,
    IconData icon, {
    @required final TextEditingController controller,
    @required final String addressField,
    @required final dynamic addressFieldValue,
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
            onChanged: (value) {
              _data[addressField] =
                  addressFieldValue is int ? int.parse(value) : value;
              widget.onAddressAdded(_data);
            },
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
