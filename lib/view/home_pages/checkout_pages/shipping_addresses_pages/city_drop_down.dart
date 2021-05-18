import 'package:flutter/material.dart';
import '../../../screen_util.dart';

class CityDropDown extends StatefulWidget {
  final List<Map<String, dynamic>> cities;
  final Function(int, String) onCitySelected;
  final int cityId;

  const CityDropDown({
    Key key,
    @required this.cities,
    @required this.onCitySelected,
    this.cityId = 0,
  }) : super(key: key);

  @override
  _CityDropDownState createState() => _CityDropDownState();
}

class _CityDropDownState extends State<CityDropDown> {
  final ScreenUtil _screenUtil = ScreenUtil();
  int _cityId;

  @override
  void initState() {
    _cityId = widget.cityId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return DropdownButton(
      value: _cityId,
      items: List.generate(
        widget.cities.length,
        (index) => DropdownMenuItem(
          value: widget.cities[index]['id'],
          child: SizedBox(
            width: _screenUtil.setWidth(300),
            child: Text(
              widget.cities[index]['name'],
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: _screenUtil.setSp(40),
              ),
            ),
          ),
        ),
      ),
      onChanged: (value) {
        setState(() {
          _cityId = value;
        });
        // print('City ID: $_cityId');

        for (var city in widget.cities) {
          if (city['id'] == _cityId) {
            widget.onCitySelected(_cityId, city['name']);
            break;
          }
        }
      },
    );
  }
}
