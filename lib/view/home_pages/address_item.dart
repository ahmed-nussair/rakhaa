import 'package:flutter/material.dart';
import '../screen_util.dart';

class AddressItem extends StatelessWidget {
  final int id;
  final String buildingNo;
  final String street;
  final int floor;
  final int department;
  final String moreDescription;
  final Map<String, dynamic> city;
  final Map<String, dynamic> governorate;

  // final String country;
  // final String zipPostalCode;

  final ScreenUtil _screenUtil = ScreenUtil();

  AddressItem({
    @required this.id,
    @required this.buildingNo,
    @required this.street,
    @required this.floor,
    @required this.department,
    @required this.moreDescription,
    @required this.city,
    @required this.governorate,
    // @required this.country,
    // @required this.zipPostalCode,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$street',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
              Text(
                ' ، ',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
              Text(
                '$buildingNo',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
            ],
          ),
          Text(
            '$moreDescription',
            style: TextStyle(fontSize: _screenUtil.setSp(40)),
          ),
          floor == -1 && department == -1
              ? Container()
              : department == -1
                  ? Text(
                      '${floors[floor]}',
                      style: TextStyle(fontSize: _screenUtil.setSp(40)),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '$department',
                          style: TextStyle(fontSize: _screenUtil.setSp(40)),
                        ),
                        Text(
                          'شقة ',
                          style: TextStyle(fontSize: _screenUtil.setSp(40)),
                        ),
                        Text(
                          ' ، ',
                          style: TextStyle(fontSize: _screenUtil.setSp(40)),
                        ),
                        Text(
                          '${floors[floor]}',
                          style: TextStyle(fontSize: _screenUtil.setSp(40)),
                        ),
                        // Text(
                        //   '$country',
                        //   style: TextStyle(fontSize: _screenUtil.setSp(40)),
                        // ),
                      ],
                    ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                '${governorate['name']}',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
              Text(
                ' ، ',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
              Text(
                '${city['name']}',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
              // Text(
              //   '$country',
              //   style: TextStyle(fontSize: _screenUtil.setSp(40)),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

Map<int, String> floors = {
  0: 'الدور الأرضي',
  1: 'الدور الأول',
  2: 'الدور الثاني',
  3: 'الدور الثالث',
  4: 'الدور الرابع',
  5: 'الدور الخامس',
  6: 'الدور السادس',
  7: 'الدور السابع',
  8: 'الدور الثامن',
  9: 'الدور التاسع',
  10: 'الدور العاشر',
  11: 'الدور الحادي عشر',
  12: 'الدور الثاني عشر',
  13: 'الدور الثالث عشر',
  14: 'الدور الرابع عشر',
  15: 'الدور الخامس عشر',
  16: 'الدور السادس عشر',
  17: 'الدور السابع عشر',
  18: 'الدور الثامن عشر',
  19: 'الدور التاسع عشر',
  20: 'الدور العشرون',
  21: 'الدور الأول بعد العشرين',
  22: 'الدور الثاني بعد العشرين',
  23: '',
  24: '',
  25: '',
  26: '',
  27: '',
  28: '',
  29: '',
  30: '',
  31: '',
  32: '',
  33: '',
  34: '',
  35: '',
  36: '',
  37: '',
  38: '',
  39: '',
  40: '',
  41: '',
  42: '',
  43: '',
  44: '',
  45: '',
  46: '',
  47: '',
  48: '',
  49: '',
  50: '',
  51: '',
  52: '',
  53: '',
  54: '',
  55: '',
  56: '',
  57: '',
  58: '',
  59: '',
  60: '',
  61: '',
  62: '',
};
