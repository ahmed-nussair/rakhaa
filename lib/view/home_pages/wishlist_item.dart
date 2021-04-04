import 'package:flutter/material.dart';

import '../screen_util.dart';

class WishListItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double afterDiscount;
  final double rating;

  // final Function onMerchantNameTapped;

  WishListItem({
    @required this.imageUrl,
    @required this.title,
    @required this.price,
    @required this.afterDiscount,
    @required this.rating,
    // @required this.onMerchantNameTapped,
  });

  @override
  _WishListItemState createState() => _WishListItemState();
}

class _WishListItemState extends State<WishListItem> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return GestureDetector(
      onTap: () {},
      child: Material(
        elevation: _screenUtil.setWidth(5),
        shadowColor: Colors.black,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_screenUtil.setHeight(10)),
              child: Container(
                height: _screenUtil.setHeight(100),
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: _screenUtil.setSp(40),
                  ),
                  overflow:
                      TextOverflow.ellipsis, // so that text ends with dots
                ),
              ),
            ),
            Divider(),
            Container(
              height: _screenUtil.setHeight(80),
              child: widget.price == widget.afterDiscount
                  ? Padding(
                      padding: EdgeInsets.all(_screenUtil.setHeight(10)),
                      child: Text(
                        ' جنيه ${widget.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: _screenUtil.setSp(40),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(_screenUtil.setHeight(10)),
                          child: Text(
                            ' جنيه${widget.afterDiscount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: _screenUtil.setSp(40),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(_screenUtil.setHeight(10)),
                          child: Text(
                            ' جنيه${widget.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: _screenUtil.setSp(40),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
