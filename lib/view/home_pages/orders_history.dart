import 'package:flutter/material.dart';
import '../screen_util.dart';
import 'orders_history_item.dart';

class OrdersHistory extends StatefulWidget {
  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return ListView(
      children: List.generate(
          _ordersHistory.length,
          (index) => OrdersHistoryItem(
                orderId: int.parse(_ordersHistory[index]['id']),
                orderDateTime: _ordersHistory[index]['dateTime'],
                orderStatus: _ordersHistory[index]['status'],
                statusColor: _ordersHistory[index]['statusColor'],
              )),
    );
  }
}

List _ordersHistory = [
  {
    'id': '105',
    'dateTime': '2021 Jan 20 13:30:33',
    'status': 'قيد التنفيذ',
    'statusColor': 0xFFffae42,
  },
  {
    'id': '104',
    'dateTime': '2021 Jan 20 13:30:33',
    'status': 'ملغي',
    'statusColor': 0xFFFF0000,
  },
  {
    'id': '103',
    'dateTime': '2021 Jan 20 13:30:33',
    'status': 'تم بنجاح',
    'statusColor': 0xFF008000,
  },
];
