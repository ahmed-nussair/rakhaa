import 'package:flutter/material.dart';

import '../../../screen_util.dart';
import 'package:geolocator/geolocator.dart';

import 'location_map.dart';

class NewAddress extends StatefulWidget {
  final Function(Map<String, String>) onAddressAdded;

  NewAddress({@required this.onAddressAdded});

  @override
  _NewAddressState createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  final ScreenUtil _screenUtil = ScreenUtil();

  final TextEditingController _line1Controller = TextEditingController();
  final TextEditingController _line2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _poController = TextEditingController();

  String _country;

  double _latitude;
  double _longitude;

  @override
  void initState() {
    _country = '';
    _latitude = 0.0;
    _longitude = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: _formField('السطر الأول', null,
              controller: _line1Controller,
              inputType: TextInputType.multiline,
              maxLines: 3),
        ),
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: _formField('السطر الثاني', null,
              controller: _line2Controller,
              inputType: TextInputType.multiline,
              maxLines: 3),
        ),
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: _formField(
                  'المحافظة',
                  null,
                  controller: _stateController,
                ),
              ),
              SizedBox(
                width: _screenUtil.setWidth(30),
              ),
              Flexible(
                flex: 1,
                child: _formField(
                  'الحي أو المركز',
                  null,
                  controller: _cityController,
                ),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(_screenUtil.setWidth(30)),
        //   child: GestureDetector(
        //     onTap: () {
        //       showDialog(
        //         context: context,
        //         child: CustomAlertDialog(
        //           titlePadding: EdgeInsets.all(0.0),
        //           contentPadding: EdgeInsets.all(0.0),
        //           content: CountryList(
        //             onCountryCodeSelected: (country) {
        //               setState(() {
        //                 _country = country;
        //               });
        //             },
        //           ),
        //         ),
        //       );
        //     },
        //     child: Container(
        //       alignment: Alignment.center,
        //       width: _screenUtil.setWidth(800),
        //       height: _screenUtil.setHeight(120),
        //       padding: EdgeInsets.all(_screenUtil.setHeight(25)),
        //       decoration: BoxDecoration(
        //         color: Color(0xfff4f4f8),
        //         borderRadius: BorderRadius.all(
        //             Radius.circular(_screenUtil.setWidth(30))),
        //       ),
        //       child: Text(
        //         _country.isNotEmpty ? _country : 'Country',
        //         style: TextStyle(
        //           fontSize: _screenUtil.setSp(40),
        //           color: Color(0xffd8cfcc),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: EdgeInsets.all(_screenUtil.setWidth(30)),
        //   child: _formField('ZIP / Postal Code', null,
        //       controller: _poController,
        //       inputType: TextInputType.numberWithOptions(
        //           decimal: false, signed: false)),
        // ),

        // Padding(
        //   padding: EdgeInsets.all(_screenUtil.setWidth(30)),
        //   child: GestureDetector(
        //     onTap: () async {
        //       Position position = await Geolocator.getCurrentPosition(
        //           desiredAccuracy: LocationAccuracy.high);
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => LocationMap(
        //                 address:
        //                     '${_line1Controller.text}\n${_line2Controller.text}',
        //                 latitude: position.latitude,
        //                 longitude: position.longitude,
        //                 onLocationSpecifiedOnMap: (lat, lon) {
        //                   setState(() {
        //                     _latitude = lat;
        //                     _longitude = lon;
        //                   });
        //                   print('Latitude: $_latitude');
        //                   print('Longitude: $_longitude');
        //                 },
        //                 editing: true,
        //               )));
        //     },
        //     child: Container(
        //       height: _screenUtil.setHeight(100),
        //       decoration: BoxDecoration(
        //         color: Color(0xfff4f4f8),
        //         borderRadius: BorderRadius.circular(_screenUtil.setWidth(30)),
        //       ),
        //       alignment: Alignment.center,
        //       child: Text(
        //         _latitude > 0 && _longitude > 0
        //             ? '$_latitude, $_longitude'
        //             : 'حدد موقعك على غوغل ماب (اختياري)',
        //         style: TextStyle(
        //           fontSize: _screenUtil.setSp(40),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _formField(
    String hintTitle,
    IconData icon, {
    @required final TextEditingController controller,
    final bool obscureText = false,
    final TextInputType inputType = TextInputType.text,
    final int maxLines = 1,
  }) {
    return Stack(
      children: [
        Container(
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            textAlign: TextAlign.end,
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
                    // color: Color(0xffd9d9d9),
                    size: _screenUtil.setSp(40),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
