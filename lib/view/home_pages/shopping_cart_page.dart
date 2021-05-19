import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screen_util.dart';

import '../../bloc/shopping_cart/shopping_cart_bloc.dart';
import '../../globals.dart' as Globals;

import 'cart_item.dart';
import 'checkout_page.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  double _total;

  List _list;

  @override
  void initState() {
    _list = [];
    _total = 0.00;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocProvider(
              create: (_) => ShoppingCartBloc()
                ..add(LoadingShoppingCart(
                    snapshot.data.getString(Globals.token))),
              child: BlocListener<ShoppingCartBloc, ShoppingCartState>(
                listener: (context, state) {
                  if (state is ShoppingCartLoadedState) {
                    setState(() {
                      _list = state.response.items;
                      _total = state.response.totalPrice;
                    });
                  }

                  if (state is ShoppingCartUpdatedState) {
                    setState(() {
                      _total = state.response.itemsTotalPrice;
                    });
                  }
                },
                child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                  builder: (context, state) {
                    if (state is LoadingShoppingCartState) {
                      return Center(
                        child: Container(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return _list.length > 0
                          ? Stack(
                              children: [
                                Column(
                                  children: [
                                    Expanded(
                                      child: ListView(
                                        children: List.generate(
                                            _list.length,
                                            (index) => Padding(
                                                  padding: EdgeInsets.all(
                                                      _screenUtil.setWidth(30)),
                                                  child: Stack(
                                              children: [
                                                CartItem(
                                                  title: _list[index].name,
                                                  imageUrl:
                                                      _list[index].imageUrl,
                                                  price: _list[index].price,
                                                  quantity:
                                                      _list[index].quantity,
                                                  onQuantityChanged:
                                                      (int newQuantity) {
                                                    setState(() {
                                                      BlocProvider.of<
                                                                  ShoppingCartBloc>(
                                                              context)
                                                          .add(UpdatingShoppingCart(
                                                              snapshot.data
                                                                  .getString(
                                                                      Globals
                                                                          .token),
                                                              _list[index].id,
                                                              newQuantity));
                                                    });
                                                  },
                                                ),
                                                Positioned(
                                                  top: _screenUtil.setWidth(30),
                                                  left:
                                                      _screenUtil.setWidth(30),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      int id = _list[index].id;
                                                      int quantity =
                                                          _list[index].quantity;
                                                      List list = _list;
                                                      list.remove(_list[index]);
                                                      setState(() {
                                                        _list = list;
                                                      });
                                                      BlocProvider.of<
                                                                  ShoppingCartBloc>(
                                                              context)
                                                          .add(UpdatingShoppingCart(
                                                              snapshot.data
                                                                  .getString(
                                                                      Globals
                                                                          .token),
                                                              id,
                                                              -quantity));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                _screenUtil
                                                                    .setWidth(
                                                                        50)),
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
                                  padding:
                                      EdgeInsets.all(_screenUtil.setWidth(20)),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'ج.م',
                                                  style: TextStyle(
                                                    fontSize:
                                                        _screenUtil.setSp(70),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width:
                                                      _screenUtil.setWidth(20),
                                                ),
                                                Text(
                                                  '$_total',
                                                  style: TextStyle(
                                                    fontSize:
                                                        _screenUtil.setSp(70),
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CheckoutPage(
                                                                          onOrderConfirmed:
                                                                              () {
                                                                            setState(() {
                                                                              _list.clear();
                                                                            });
                                                                          },
                                                                        )));
                                                      },
                                                child: Text(
                                                  'متابعة الشراء',
                                                  style: TextStyle(
                                                    fontSize:
                                                        _screenUtil.setSp(70),
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
                          ),
                          state is UpdatingShoppingCartState
                              ? Positioned(
                                  top: 0.0,
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    color: Colors.black.withOpacity(0.5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                              Container(
                                                  width: 100,
                                                  height: 100,
                                                  child:
                                                      CircularProgressIndicator()),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ],
                            )
                          : Center(
                              child: Text(
                                'ليس لديك أي صنف في عربة التسوق',
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(50),
                                ),
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
      ),
    );
  }
}
