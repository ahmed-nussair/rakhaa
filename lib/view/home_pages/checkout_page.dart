import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'checkout_pages/shipping_address_page.dart';
// import 'checkout_pages/payment_method_page.dart';
import 'checkout_pages/confirm_order_page.dart';

import '../screen_util.dart';

class CheckoutPage extends StatefulWidget {
  final Function onOrderConfirmed;

  CheckoutPage({Key key, @required this.onOrderConfirmed}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  final int tabsNumber = 2;

  final int shippingAddressIndex = 0;

  // final int paymentMethodIndex = 1;
  // final int confirmOrderIndex = 2;
  final int confirmOrderIndex = 1;

  int _currentTabIndex;

  Map<String, dynamic> chosenAddress;

  @override
  void initState() {
    _currentTabIndex = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            ),
          ),
          centerTitle: true,
          title: Text(
            'متابعة الشراء',
            style: TextStyle(
              color: Colors.black87,
              fontSize: _screenUtil.setSp(50),
            ),
          ),
        ),
        body: _currentTabIndex == shippingAddressIndex
            ? ShippingAddressPage(
                onAddressSelected: (data) {
                  setState(() {
                    chosenAddress = data;
                  });
                },
                onConfirmAddress: (data) {
                  setState(() {
                    _currentTabIndex = confirmOrderIndex;
                  });
                },
              )
            : _currentTabIndex == confirmOrderIndex
                ? ConfirmOrderPage(
                    address: chosenAddress,
                    onChangeAddress: () {
                      setState(() {
                        _currentTabIndex = shippingAddressIndex;
                      });
                    },
                    // onChangePaymentMethod: () {
                    //   setState(() {
                    //     _currentTabIndex = paymentMethodIndex;
                    //   });
                    //   _tabController.animateTo(_currentTabIndex);
                    // },

                    onConfirmOrder: () {
                      widget.onOrderConfirmed();
                      Navigator.of(context).pop();
                      Fluttertoast.showToast(
                        msg:
                            'تم إرسال طلبك بنجاح. يمكنك متابعة حالة طلبك من خلال سجل الطلبات.',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black54,
                        textColor: Colors.white,
                        fontSize: _screenUtil.setSp(50),
                      );
                    },
                  )
                : Container(),
      ),
    );
  }
}
