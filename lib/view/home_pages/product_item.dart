import 'package:flutter/material.dart';
import 'product_item_widgets/shopping_cart_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen_util.dart';
import 'offer_ribbon.dart';
import 'product_item_widgets/wish_list_icon.dart';
import '../../globals.dart' as Globals;

class ProductItem extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final double price;
  final double afterDiscount;
  final double percentage;

  final ScreenUtil _screenUtil = ScreenUtil();

  ProductItem({
    @required this.id,
    @required this.imageUrl,
    @required this.title,
    @required this.price,
    @required this.afterDiscount,
    @required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String token = snapshot.data.getString(Globals.token);
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
                          imageUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setHeight(10)),
                        child: Container(
                          height: _screenUtil.setHeight(150),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: _screenUtil.setSp(40),
                            ),
                            overflow: TextOverflow
                                .ellipsis, // so that text ends with dots
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        height: _screenUtil.setHeight(80),
                        child: price == afterDiscount
                            ? Padding(
                                padding:
                                    EdgeInsets.all(_screenUtil.setHeight(10)),
                                child: Text(
                                  ' جنيه ${price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontSize: _screenUtil.setSp(40),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(
                                        _screenUtil.setHeight(10)),
                                    child: Text(
                                      ' جنيه${afterDiscount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: _screenUtil.setSp(40),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        _screenUtil.setHeight(10)),
                                    child: Text(
                                      ' جنيه${price.toStringAsFixed(2)}',
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
                  token == null || token == ''
                      ? Container()
                      : Positioned(
                          top: _screenUtil.setHeight(20),
                          left: _screenUtil.setWidth(20),
                          child: Column(
                            children: [
                              WishListIcon(
                                id: id,
                              ),
                              SizedBox(
                                height: _screenUtil.setHeight(30),
                              ),
                              ShoppingCartIcon(id: id),
                            ],
                          ),
                        ),
                  percentage > 0
                      ? Positioned(
                          top: 0.0,
                          right: 0.0,
                          child: Container(
                            height: _screenUtil.setWidth(180),
                            width: _screenUtil.setWidth(180),
                            child: OfferRibbon(
                              percentage: percentage,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
