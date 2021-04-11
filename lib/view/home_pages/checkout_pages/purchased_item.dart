import 'package:flutter/material.dart';

import '../../screen_util.dart';

class PurchasedItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;

  final ScreenUtil _screenUtil = ScreenUtil();

  PurchasedItem({
    @required this.imageUrl,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return Material(
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
                title,
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
                    '${price.toStringAsFixed(2)}',
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
                  Text(
                    '$quantity',
                    style: TextStyle(
                      fontSize: _screenUtil.setSp(40),
                      fontWeight: FontWeight.bold,
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
                imageUrl,
                height: _screenUtil.setHeight(300),
                width: _screenUtil.setWidth(300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
