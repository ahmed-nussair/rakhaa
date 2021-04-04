import 'package:flutter/material.dart';

import '../screen_util.dart';

class CartItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final Function(int) onQuantityChanged;

  final ScreenUtil _screenUtil = ScreenUtil();

  CartItem({
    @required this.imageUrl,
    @required this.title,
    @required this.price,
    this.quantity = 1,
    @required this.onQuantityChanged,
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
                  QuantityWidget(
                    quantity: quantity,
                    onQuantityChanged: (quantity) {
                      onQuantityChanged(quantity);
                    },
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

class QuantityWidget extends StatefulWidget {
  final int quantity;
  final Function(int) onQuantityChanged;

  QuantityWidget({@required this.quantity, @required this.onQuantityChanged});

  @override
  _QuantityWidgetState createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  int _quantity;

  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  void initState() {
    _quantity = widget.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _quantity++;
            });
            widget.onQuantityChanged(_quantity);
          },
          child: Material(
            elevation: 0.7,
            shadowColor: Colors.black26,
            child: Container(
              height: _screenUtil.setHeight(80),
              width: _screenUtil.setWidth(100),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(_screenUtil.setWidth(20))),
              child: Icon(Icons.add),
            ),
          ),
        ),
        SizedBox(
          width: _screenUtil.setWidth(20),
        ),
        Container(
          width: _screenUtil.setWidth(50),
          alignment: Alignment.center,
          child: Text(
            '$_quantity',
            style: TextStyle(
              fontSize: _screenUtil.setSp(40),
            ),
          ),
        ),
        SizedBox(
          width: _screenUtil.setWidth(20),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (_quantity > 1) _quantity--;
            });
            widget.onQuantityChanged(_quantity);
          },
          child: Material(
            elevation: 0.7,
            shadowColor: Colors.black26,
            child: Container(
              height: _screenUtil.setHeight(80),
              width: _screenUtil.setWidth(100),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(_screenUtil.setWidth(20))),
              child: Icon(Icons.remove),
            ),
          ),
        ),
      ],
    );
  }
}
