import 'package:flutter/material.dart';
import '../../../screen_util.dart';

class GovernoratesDropDown extends StatefulWidget {
  final List<Map<String, dynamic>> governorates;
  final Function(int, String) onGovernorateSelected;
  final int governorateId;

  const GovernoratesDropDown({
    Key key,
    @required this.onGovernorateSelected,
    @required this.governorates,
    this.governorateId = 0,
  }) : super(key: key);

  @override
  _GovernoratesDropDownState createState() => _GovernoratesDropDownState();
}

class _GovernoratesDropDownState extends State<GovernoratesDropDown> {
  final ScreenUtil _screenUtil = ScreenUtil();

  int _governorateId;

  @override
  void initState() {
    _governorateId = widget.governorateId;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return DropdownButton(
      value: _governorateId,
      items: List.generate(
        widget.governorates.length,
        (index) => DropdownMenuItem(
          value: widget.governorates[index]['id'],
          child: SizedBox(
            width: _screenUtil.setWidth(300),
            child: Text(
              widget.governorates[index]['name'],
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
          _governorateId = value;
        });

        for (var governorate in widget.governorates) {
          if (governorate['id'] == _governorateId) {
            widget.onGovernorateSelected(_governorateId, governorate['name']);
            break;
          }
        }
      },
    );
  }
}
