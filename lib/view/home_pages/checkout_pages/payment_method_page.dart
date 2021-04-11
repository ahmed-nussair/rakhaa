import 'package:flutter/material.dart';

import '../../screen_util.dart';

class PaymentMethodPage extends StatefulWidget {
  final Function onConfirmPaymentMethod;
  final Function onBackToShippingAddressPage;

  PaymentMethodPage({
    @required this.onConfirmPaymentMethod,
    @required this.onBackToShippingAddressPage,
  });

  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text('Payment Method Page'),
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
                      widget.onConfirmPaymentMethod();
                    },
                    title: Text(
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
          Padding(
            padding: EdgeInsets.all(_screenUtil.setWidth(10)),
            child: Stack(
              children: [
                Container(
                  color: Color(0xff3573ac),
                  child: ListTile(
                    onTap: () {
                      widget.onBackToShippingAddressPage();
                    },
                    title: Text(
                      'حدد عنوان الشحن',
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
                  left: _screenUtil.setWidth(30),
                  child: Icon(
                    Icons.arrow_back,
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
