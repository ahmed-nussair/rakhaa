import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/wish_list/wish_list_bloc.dart';
import '../../globals.dart' as Globals;
import '../screen_util.dart';
import 'offer_ribbon.dart';

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
                      overflow:
                          TextOverflow.ellipsis, // so that text ends with dots
                    ),
                  ),
                ),
                Divider(),
                Container(
                  height: _screenUtil.setHeight(80),
                  child: price == afterDiscount
                      ? Padding(
                          padding: EdgeInsets.all(_screenUtil.setHeight(10)),
                          child: Text(
                            ' جنيه ${price.toStringAsFixed(2)}',
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
                                ' جنيه${afterDiscount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(40),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.all(_screenUtil.setHeight(10)),
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
            Positioned(
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
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: _screenUtil.setSp(70),
                  ),
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
}

class WishListIcon extends StatefulWidget {
  final int id;

  WishListIcon({@required this.id});

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
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return BlocProvider(
            create: (_) => WishListBloc()
              ..add(LoadingWishList(snapshot.data.getString(Globals.token),
                  productId: widget.id)),
            child: BlocListener<WishListBloc, WishListState>(
              listener: (context, state) {
                if (state is AddedToWishListState) {
                  setState(() {
                    _wishListed = true;
                  });
                } else if (state is DeletedFromWishListState) {
                  setState(() {
                    _wishListed = false;
                  });
                } else if (state is WishListLoadedState) {
                  setState(() {
                    _wishListed = state.products.length > 0 ? true : false;
                  });
                } else {
                  setState(() {
                    _wishListed = false;
                  });
                }
              },
              child: BlocBuilder<WishListBloc, WishListState>(
                builder: (context, state) {
                  if (state is LoadingWishListState ||
                      state is AddingToWishListState ||
                      state is DeletingFromWishListState) {
                    return Container(
                      alignment: Alignment.center,
                      width: _screenUtil.setWidth(40),
                      height: _screenUtil.setHeight(40),
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        if (_wishListed) {
                          BlocProvider.of<WishListBloc>(context).add(
                              DeletingFromWishList(
                                  snapshot.data.getString(Globals.token),
                                  widget.id));
                        } else {
                          BlocProvider.of<WishListBloc>(context).add(
                              AddingToWishList(
                                  snapshot.data.getString(Globals.token),
                                  widget.id));
                        }
                        // BlocProvider.of<WishListBloc>(context).add(DeletingFromWishList(snapshot.data.getString(Globals.token), widget.id));
                        // setState(() {
                        //   _wishListed = _wishListed ? false : true;
                        // });
                      },
                      child: Icon(
                        _wishListed ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: _screenUtil.setSp(70),
                      ),
                    );
                  }
                },
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
