import 'package:flutter/material.dart';

import '../../screen_util.dart';

import 'purchased_item.dart';

import '../address_item.dart';

class ConfirmOrderPage extends StatefulWidget {
  final Function onChangeAddress;

  // final Function onChangePaymentMethod;
  final Function onConfirmOrder;
  final Map<String, dynamic> address;

  ConfirmOrderPage({
    @required this.onChangeAddress,
    @required this.address,
    // @required this.onChangePaymentMethod,
    @required this.onConfirmOrder,
  });

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    // print('Received Address: ${widget.address}');
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'طلبك كالآتي',
              style: TextStyle(
                fontSize: _screenUtil.setSp(50),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Column(
          children: List.generate(
              _purchasedItems.length,
              (index) => Padding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    child: PurchasedItem(
                      title: _purchasedItems[index]['item']['title'],
                      imageUrl: _purchasedItems[index]['item']['imageUrl'],
                      price: _purchasedItems[index]['price'],
                      quantity: _purchasedItems[index]['quantity'],
                    ),
                  )),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ج.م',
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(50),
                      ),
                    ),
                    SizedBox(
                      width: _screenUtil.setWidth(20),
                    ),
                    Text(
                      '${121.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(50),
                      ),
                    ),
                  ],
                ),
                Text(
                  'الحساب الكلي',
                  style: TextStyle(
                    fontSize: _screenUtil.setSp(50),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ج.م',
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(50),
                      ),
                    ),
                    SizedBox(
                      width: _screenUtil.setWidth(20),
                    ),
                    Text(
                      '${20.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: _screenUtil.setSp(50),
                      ),
                    ),
                  ],
                ),
                Text(
                  'مصاريف الشحن',
                  style: TextStyle(
                    fontSize: _screenUtil.setSp(50),
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(),

        // Shipping Address Section
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'عنوان الشحن',
              style: TextStyle(
                fontSize: _screenUtil.setSp(50),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        AddressItem(
          id: widget.address['id'],
          buildingNo: widget.address['buildingNo'],
          city: widget.address['city'] as Map<String, dynamic>,
          governorate: widget.address['governorate'] as Map<String, dynamic>,
          // country: _addressesList[index]['country'],
          // zipPostalCode: _addressesList[index]['zipPostalCode'],
          department: widget.address['department'],
          floor: widget.address['floor'],
          street: widget.address['street'],
          moreDescription: widget.address['moreDescription'],
        ),
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(10)),
          child: Stack(
            children: [
              Container(
                color: Color(0xff3573ac),
                child: ListTile(
                  onTap: () {
                    widget.onChangeAddress();
                  },
                  title: Text(
                    'هل تريد تغيير عنوان الشحن؟',
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
        Divider(),

        // Payment Method Section

        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'طريقة الدفع',
              style: TextStyle(
                fontSize: _screenUtil.setSp(50),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'نقدًا عند الاستلام',
                style: TextStyle(
                  fontSize: _screenUtil.setSp(50),
                ),
              ),
              SizedBox(
                width: _screenUtil.setWidth(20),
              ),
              Image.asset(
                'assets/cash.png',
                height: _screenUtil.setWidth(80),
                width: _screenUtil.setWidth(80),
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(_screenUtil.setWidth(10)),
        //   child: Stack(
        //     children: [
        //       Container(
        //         color: Color(0xff3573ac),
        //         child: ListTile(
        //           onTap: () {
        //             widget.onChangePaymentMethod();
        //           },
        //           title: Text(
        //             'هل تريد تغيير طريقة الدفع؟',
        //             textAlign: TextAlign.center,
        //             style: TextStyle(
        //               color: Colors.white,
        //               fontSize: _screenUtil.setSp(50),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         top: 0.0,
        //         bottom: 0.0,
        //         left: _screenUtil.setWidth(30),
        //         child: Icon(
        //           Icons.arrow_back,
        //           color: Colors.white,
        //           size: _screenUtil.setSp(50),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        Divider(),

        // Confirm Order Button
        Padding(
          padding: EdgeInsets.all(_screenUtil.setWidth(10)),
          child: Container(
            color: Color(0xff3573ac),
            child: ListTile(
              onTap: () {
                widget.onConfirmOrder();
              },
              title: Text(
                'تأكيد الطلب',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: _screenUtil.setSp(50),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List _purchasedItems = [
  {
    'quantity': 2,
    'price': 3.0,
    'item': {
      'imageUrl': 'https://i.ibb.co/M9f86L6/aquafina-0-5.jpg',
      'title': 'أكوافينا 0.5 لتر',
      'price': 3.0,
      'afterDiscount': 3.0,
    },
  },
  {
    'quantity': 1,
    'price': 100.0,
    'item': {
      'imageUrl': 'https://i.ibb.co/80CFJtt/aquafina-19.jpg',
      'title': 'أكوافينا 19 جالون',
      'price': 100.0,
      'afterDiscount': 100.0,
    },
  },
  {
    'quantity': 3,
    'price': 5.0,
    'item': {
      'imageUrl': 'https://i.ibb.co/LSpKByw/baraka-1-5.jpg',
      'title': 'بركة 1.5 لتر',
      'price': 5.0,
      'afterDiscount': 5.0,
    },
  },
];
