import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rakhaa/bloc/orders/orders_bloc.dart';

import '../screen_util.dart';

class OrdersHistoryItem extends StatefulWidget {
  final String token;
  final int orderId;
  final DateTime orderDateTime;
  final String orderStatus;
  final int statusColor;

  OrdersHistoryItem({
    @required this.token,
    @required this.orderId,
    @required this.orderDateTime,
    @required this.orderStatus,
    @required this.statusColor,
  });

  @override
  _OrdersHistoryItemState createState() => _OrdersHistoryItemState();
}

class _OrdersHistoryItemState extends State<OrdersHistoryItem> {
  final ScreenUtil _screenUtil = ScreenUtil();

  bool _purchasedItemsShowed;

  List<Map<String, dynamic>> _cartItems;

  @override
  void initState() {
    _cartItems = [];
    _purchasedItemsShowed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return BlocProvider(
      create: (_) => OrdersBloc(),
      child: BlocListener<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state is OrderItemLoadedState) {
            // print(state.detailedOrder.toJson());
            setState(() {
              _purchasedItemsShowed = true;
              for (var item in state.detailedOrder.items) {
                _cartItems.add({
                  'quantity': item.quantity,
                  'price': item.totalPrice,
                  'item': {
                    'imageUrl': item.imageUrl,
                    'title': item.name,
                    'price': item.price,
                    'afterDiscount':
                        item.price - (item.price * item.discount / 100),
                  },
                });
              }
            });
          }
        },
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (!_purchasedItemsShowed) {
                          BlocProvider.of<OrdersBloc>(context).add(
                              LoadingOrderItem(widget.token, widget.orderId));
                        } else {
                          setState(() {
                            _purchasedItemsShowed = false;
                          });
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                        child: state is LoadingOrderItemState
                            ? Container(
                                alignment: Alignment.center,
                                width: _screenUtil.setWidth(70),
                                height: _screenUtil.setHeight(70),
                                child: CircularProgressIndicator(),
                              )
                            : Icon(
                                _purchasedItemsShowed
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_left,
                                size: _screenUtil.setSp(70),
                              ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              ' ${widget.orderId} رقم الطلب',
                              style: TextStyle(
                                fontSize: _screenUtil.setSp(50),
                              ),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              '${widget.orderDateTime}',
                              style: TextStyle(
                                fontSize: _screenUtil.setSp(50),
                              ),
                              textAlign: TextAlign.end,
                            ),
                            Text(
                              '${widget.orderStatus}',
                              style: TextStyle(
                                fontSize: _screenUtil.setSp(50),
                                color: Color(widget.statusColor),
                              ),
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
                _purchasedItemsShowed
                    ? OrderPurchasedItems(
                        items: _cartItems,
                      )
                    : Container(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class OrderPurchasedItems extends StatelessWidget {
  final List items;
  final ScreenUtil _screenUtil = ScreenUtil();

  OrderPurchasedItems({
    @required this.items,
  });

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return Column(
      children: [
        Column(
          children: List.generate(
              items.length,
              (index) => Padding(
                    padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                    child: Material(
                      elevation: 3.0,
                      shadowColor: Colors.grey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                items[index]['item']['title'],
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(40),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'ج.م',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(40),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _screenUtil.setWidth(20),
                                  ),
                                  Text(
                                    '${(items[index]['price']).toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(40),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _screenUtil.setWidth(20),
                                  ),
                                  Text(
                                    ':',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(40),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'السعر',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(40),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: _screenUtil.setWidth(50),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${items[index]['quantity']}',
                                      style: TextStyle(
                                        fontSize: _screenUtil.setSp(40),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _screenUtil.setWidth(20),
                                  ),
                                  Text(
                                    ':',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(40),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'الكمية',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(40),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: _screenUtil.setWidth(50),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              color: Colors.white,
                              child: Image.network(
                                items[index]['item']['imageUrl'],
                                height: _screenUtil.setHeight(300),
                                width: _screenUtil.setWidth(300),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
        Divider(),
      ],
    );
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
