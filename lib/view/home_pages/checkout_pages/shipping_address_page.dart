import 'package:flutter/material.dart';

import '../../screen_util.dart';
import 'shipping_addresses_pages/addresses_list.dart';
import 'shipping_addresses_pages/new_address.dart';

class ShippingAddressPage extends StatefulWidget {
  final Function onConfirmAddress;

  ShippingAddressPage({
    @required this.onConfirmAddress,
  });

  @override
  _ShippingAddressPageState createState() => _ShippingAddressPageState();
}

class _ShippingAddressPageState extends State<ShippingAddressPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  ShippingAddress _address;

  @override
  void initState() {
    // _address = ShippingAddress.FromAddresses;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'حدد عنوان الشحن',
                    style: TextStyle(
                      fontSize: _screenUtil.setSp(70),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'اختر من قائمة عناوينك',
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(50),
                      ),
                    ),
                    Radio(
                        value: ShippingAddress.FromAddresses,
                        groupValue: _address,
                        onChanged: (value) {
                          setState(() {
                            _address = value;
                          });
                        }),
                  ],
                ),
                _address == ShippingAddress.FromAddresses
                    ? AddressesList(addressesList: addresses)
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'إنشاء عنوان جديد',
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(50),
                      ),
                    ),
                    Radio(
                        value: ShippingAddress.NewAddress,
                        groupValue: _address,
                        onChanged: (value) {
                          setState(() {
                            _address = value;
                          });
                        }),
                  ],
                ),
                _address == ShippingAddress.NewAddress
                    ? NewAddress(
                        onAddressAdded: (data) {},
                      )
                    : Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(10)),
            child: Stack(
              children: [
                Container(
                  color: Color(0xff3573ac),
                  child: ListTile(
                    onTap: () {
                      widget.onConfirmAddress();
                    },
                    title: Text(
                      // 'حدد طريقة الدفع',
                      'راجع تفاصيل طلبك',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _screenUtil.setSp(50),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.0,
                  bottom: 0.0,
                  right: _screenUtil.setWidth(30),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: _screenUtil.setSp(50),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum ShippingAddress { FromAddresses, NewAddress }

final List addresses = [
  {
    'firstLine': '40 ب ، السويسري ب ، الحي العاشر',
    'secondLine': 'أمام مدرسة سعد بن أبي وقاص',
    'city': 'مدينة نصر',
    'state': 'القاهرة',
    'country': 'مصر',
    'zipPostalCode': '5435435',
    'latitude': '30.046348',
    'longitude': '31.366725',
  },
  {
    'firstLine': '40B, El-Swissry B, The 10th District',
    'secondLine': '',
    'city': 'Nasr City',
    'state': 'Cairo',
    'country': 'Egypt',
    'zipPostalCode': '11134',
    'latitude': '30.047508',
    'longitude': '31.352309',
  },
];
