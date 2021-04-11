import 'package:flutter/material.dart';

import '../../../screen_util.dart';
import '../../address_item.dart';

class AddressesList extends StatefulWidget {
  final List addressesList;

  AddressesList({
    @required this.addressesList,
  });

  @override
  _AddressesListState createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  final ScreenUtil _screenUtil = ScreenUtil();

  Map _map;

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return Column(
      children: List.generate(widget.addressesList.length, (index) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.all(_screenUtil.setHeight(50)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AddressItem(
                      firstLine: widget.addressesList[index]['firstLine'],
                      secondLine: widget.addressesList[index]['secondLine'],
                      city: widget.addressesList[index]['city'],
                      state: widget.addressesList[index]['state'],
                      // country: widget.addressesList[index]['country'],
                      // zipPostalCode: widget.addressesList[index]['zipPostalCode'],
                      locationLatitude:
                          double.parse(widget.addressesList[index]['latitude']),
                      locationLongitude: double.parse(
                          widget.addressesList[index]['longitude']),
                    ),
                  ),
                  Radio(
                      value: widget.addressesList[index],
                      groupValue: _map,
                      onChanged: (value) {
                        setState(() {
                          _map = value;
                        });
                      }),
                ],
              ),
            ),
            Divider(),
          ],
        );
      }),
    );
  }
}
