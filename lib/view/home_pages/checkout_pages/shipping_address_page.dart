import 'package:flutter/material.dart';

import '../../screen_util.dart';

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

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Shipping Address Page'),
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
                      'حدد طريقة الدفع',
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
