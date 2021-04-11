import 'package:flutter/material.dart';

import 'checkout_pages/shipping_address_page.dart';
import 'checkout_pages/payment_method_page.dart';
import 'checkout_pages/confirm_order_page.dart';

import '../screen_util.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage>
    with TickerProviderStateMixin {
  final ScreenUtil _screenUtil = ScreenUtil();

  final int tabsNumber = 2;

  final int shippingAddressIndex = 0;

  // final int paymentMethodIndex = 1;
  // final int confirmOrderIndex = 2;
  final int confirmOrderIndex = 1;

  TabController _tabController;

  int _currentTabIndex;

  @override
  void initState() {
    _currentTabIndex = 0;

    _tabController = TabController(
      length: tabsNumber,
      vsync: this,
      initialIndex: _currentTabIndex,
    );

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
        body: Scaffold(
          // appBar: TabBar(
          //   controller: _tabController,
          //   tabs: [
          //     Tab(
          //       child: Text(
          //         'عنوان الشحن',
          //         style: TextStyle(color: Colors.black,
          //           fontSize: _screenUtil.setSp(40),
          //         ),
          //       ),
          //     ),
          //     Tab(
          //       child: Text(
          //         'طريقة الدفع',
          //         style: TextStyle(color: Colors.black,
          //           fontSize: _screenUtil.setSp(40),
          //         ),
          //       ),
          //     ),
          //     Tab(
          //       child: Text(
          //         'تأكيد الشراء',
          //         style: TextStyle(color: Colors.black,
          //           fontSize: _screenUtil.setSp(40),
          //         ),
          //       ),
          //     ),
          //   ],
          //   onTap: (index) {
          //     // switch (index) {
          //     //   case 0: // When tapped on first tab
          //     //     setState(() {
          //     //       _currentTabIndex = index;
          //     //     });
          //     //     break;
          //     //   case 1: // When tapped on second tab
          //     //     setState(() {
          //     //       _currentTabIndex = index;
          //     //     });
          //     //     break;
          //     //   case 2: // When tapped on third tab
          //     //     _tabController.animateTo(index);
          //     //     setState(() {
          //     //       _currentTabIndex = index;
          //     //     });
          //     //     break;
          //     // }
          //   },
          // ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              ShippingAddressPage(
                onConfirmAddress: () {
                  setState(() {
                    // _currentTabIndex = paymentMethodIndex;
                    _currentTabIndex = confirmOrderIndex;
                  });
                  _tabController.animateTo(_currentTabIndex);
                },
              ),
              // PaymentMethodPage(
              //   onConfirmPaymentMethod: () {
              //     setState(() {
              //       _currentTabIndex = confirmOrderIndex;
              //     });
              //     _tabController.animateTo(_currentTabIndex);
              //   },
              //   onBackToShippingAddressPage: () {
              //     setState(() {
              //       _currentTabIndex = shippingAddressIndex;
              //     });
              //     _tabController.animateTo(_currentTabIndex);
              //   },
              // ),
              ConfirmOrderPage(
                onChangeAddress: () {
                  setState(() {
                    _currentTabIndex = shippingAddressIndex;
                  });
                  _tabController.animateTo(_currentTabIndex);
                },
                // onChangePaymentMethod: () {
                //   setState(() {
                //     _currentTabIndex = paymentMethodIndex;
                //   });
                //   _tabController.animateTo(_currentTabIndex);
                // },

                onConfirmOrder: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
