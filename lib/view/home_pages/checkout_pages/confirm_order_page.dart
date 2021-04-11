import 'package:flutter/material.dart';

import '../../screen_util.dart';

import 'purchased_item.dart';

import '../address_item.dart';

class ConfirmOrderPage extends StatefulWidget {
  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

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
          firstLine: '40 السويسري ب ، الحي العاشر',
          secondLine: 'أمام مدرسة سعد بن أبي وقاص',
          city: 'مدينة نصر',
          state: 'القاهرة',
          country: 'مصر',
          zipPostalCode: '3432432',
          locationLatitude: 0.0,
          locationLongitude: 0.0,
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
