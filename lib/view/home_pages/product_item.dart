import 'package:flutter/material.dart';
import '../screen_util.dart';
import 'offer_ribbon.dart';

class ProductItem extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double afterDiscount;
  final double percentage;

  // final Function onMerchantNameTapped;

  ProductItem({
    @required this.imageUrl,
    @required this.title,
    @required this.price,
    @required this.afterDiscount,
    @required this.percentage,
    // @required this.onMerchantNameTapped,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return GestureDetector(
      onTap: () {},
      child: Material(
        elevation: _screenUtil.setWidth(5),
        shadowColor: Colors.black,
        child: Stack(
          children: [
            Column(
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
                    height: _screenUtil.setHeight(150),
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
                              padding:
                                  EdgeInsets.all(_screenUtil.setHeight(10)),
                              child: Text(
                                ' جنيه${widget.afterDiscount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(40),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.all(_screenUtil.setHeight(10)),
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
            Positioned(
              top: _screenUtil.setHeight(20),
              left: _screenUtil.setWidth(20),
              child: Column(
                children: [
                  WishListIcon(),
                  SizedBox(
                    height: _screenUtil.setHeight(30),
                  ),
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: _screenUtil.setSp(70),
                  ),
                ],
              ),
            ),
            widget.percentage > 0
                ? Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Container(
                      height: _screenUtil.setWidth(180),
                      width: _screenUtil.setWidth(180),
                      child: OfferRibbon(
                        percentage: widget.percentage,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class WishListIcon extends StatefulWidget {
  @override
  _WishListIconState createState() => _WishListIconState();
}

class _WishListIconState extends State<WishListIcon> {
  final ScreenUtil _screenUtil = ScreenUtil();

  bool _wishListed;

  @override
  void initState() {
    _wishListed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _wishListed = _wishListed ? false : true;
        });
      },
      child: Icon(
        _wishListed ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
        size: _screenUtil.setSp(70),
      ),
    );
  }
}
