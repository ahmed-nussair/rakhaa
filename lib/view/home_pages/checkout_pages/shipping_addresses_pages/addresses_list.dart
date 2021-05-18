import 'package:flutter/material.dart';

import '../../../screen_util.dart';
import '../../address_item.dart';

class AddressesList extends StatefulWidget {
  final List<Map<String, dynamic>> addressesList;
  final Function(Map<String, dynamic>) onAddressSelected;

  AddressesList({
    @required this.addressesList,
    @required this.onAddressSelected,
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
                      id: widget.addressesList[index]['id'],
                      buildingNo: widget.addressesList[index]['buildingNo'],
                      city: widget.addressesList[index]['city'],
                      governorate: widget.addressesList[index]['governorate'],
                      // country: _addressesList[index]['country'],
                      // zipPostalCode: _addressesList[index]['zipPostalCode'],
                      department: widget.addressesList[index]['department'],
                      floor: widget.addressesList[index]['floor'],
                      street: widget.addressesList[index]['street'],
                      moreDescription: widget.addressesList[index]
                          ['moreDescription'],
                    ),
                  ),
                  Radio(
                      value: widget.addressesList[index],
                      groupValue: _map,
                      onChanged: (value) {
                        setState(() {
                          _map = value;
                        });
                        widget.onAddressSelected(widget.addressesList[index]);
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
