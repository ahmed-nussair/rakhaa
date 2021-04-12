import 'package:flutter/material.dart';
import '../screen_util.dart';

import 'cart_item.dart';
import 'checkout_page.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  double _total;

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    _total = _calculateTotal(_cartItems);
    return _cartItems.length > 0
        ? Column(
            children: [
              Expanded(
                child: ListView(
                  children: List.generate(
                      _cartItems.length,
                      (index) => Padding(
                            padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                            child: Stack(
                              children: [
                                CartItem(
                                  title: _cartItems[index]['item']['title'],
                                  imageUrl: _cartItems[index]['item']
                                      ['imageUrl'],
                                  price: _cartItems[index]['price'],
                                  quantity: _cartItems[index]['quantity'],
                                  onQuantityChanged: (int newQuantity) {
                                    setState(() {
                                      _cartItems[index]['quantity'] =
                                          newQuantity;
                                      _total = _calculateTotal(_cartItems);
                                    });
                                  },
                                ),
                                Positioned(
                                  top: _screenUtil.setWidth(30),
                                  left: _screenUtil.setWidth(30),
                                  child: GestureDetector(
                                    onTap: () {
                                      _cartItems.remove(_cartItems[index]);
                                      setState(() {
                                        _total = _calculateTotal(_cartItems);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                            _screenUtil.setWidth(50)),
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                ),
              ),
              Container(
                height: _screenUtil.setHeight(400),
                color: Color(0xff3573ac),
                child: Padding(
                  padding: EdgeInsets.all(_screenUtil.setWidth(20)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ج.م',
                                  style: TextStyle(
                                    fontSize: _screenUtil.setSp(70),
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: _screenUtil.setWidth(20),
                                ),
                                Text(
                                  '${_total.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: _screenUtil.setSp(70),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: _screenUtil.setWidth(20),
                          ),
                          Text(
                            ':',
                            style: TextStyle(
                              fontSize: _screenUtil.setSp(70),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'الإجمالي',
                            style: TextStyle(
                              fontSize: _screenUtil.setSp(70),
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: _screenUtil.setHeight(50),
                      ),
                      Container(
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CheckoutPage()));
                                },
                                child: Text(
                                  'متابعة الشراء',
                                  style: TextStyle(
                                    fontSize: _screenUtil.setSp(70),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              bottom: 0.0,
                              right: 0.0,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: _screenUtil.setSp(70),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: Text(
              'ليس لديك أي صنف في سلة المشتريات',
              style: TextStyle(
                fontSize: _screenUtil.setSp(50),
              ),
            ),
          );
  }

  double _calculateTotal(List items) {
    double total = 0;

    for (int i = 0; i < items.length; i++) {
      total += items[i]['price'] * double.parse('${items[i]['quantity']}');
    }
    return total;
  }
}

List _cartItems = [
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
