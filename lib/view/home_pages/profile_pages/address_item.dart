import 'package:flutter/material.dart';
import 'location_map.dart';
import '../../screen_util.dart';

class AddressItem extends StatelessWidget {
  final String firstLine;
  final String secondLine;
  final String city;
  final String state;
  final String country;
  final String zipPostalCode;
  final double locationLatitude;
  final double locationLongitude;

  final ScreenUtil _screenUtil = ScreenUtil();

  AddressItem({
    @required this.firstLine,
    @required this.city,
    @required this.state,
    @required this.country,
    this.secondLine = '',
    @required this.zipPostalCode,
    @required this.locationLatitude,
    @required this.locationLongitude,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          secondLine.isNotEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      firstLine,
                      style: TextStyle(fontSize: _screenUtil.setSp(40)),
                    ),
                    Text(
                      secondLine,
                      style: TextStyle(fontSize: _screenUtil.setSp(40)),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      firstLine,
                      style: TextStyle(fontSize: _screenUtil.setSp(40)),
                    ),
                  ],
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '$city, ',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
              Text(
                '$state, ',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
              Text(
                '$country',
                style: TextStyle(fontSize: _screenUtil.setSp(40)),
              ),
            ],
          ),
          Text(
            'الرمز البريدي: $zipPostalCode',
            style: TextStyle(fontSize: _screenUtil.setSp(40)),
          ),
          GestureDetector(
            onTap: () {
              String address = secondLine.isNotEmpty
                  ? '$firstLine\n$secondLine'
                  : '$firstLine';
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LocationMap(
                        latitude: locationLatitude,
                        longitude: locationLongitude,
                        address: address,
                      )));
            },
            child: Text(
              'Show location on the map',
              style: TextStyle(
                color: Colors.blue,
                fontSize: _screenUtil.setSp(40),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
