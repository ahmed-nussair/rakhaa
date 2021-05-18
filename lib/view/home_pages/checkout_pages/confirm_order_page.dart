import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../screen_util.dart';

import 'purchased_item.dart';

import '../address_item.dart';

import '../../../globals.dart' as Globals;

class ConfirmOrderPage extends StatefulWidget {
  final Function onChangeAddress;

  // final Function onChangePaymentMethod;
  final Function onConfirmOrder;
  final Map<String, dynamic> address;

  ConfirmOrderPage({
    @required this.onChangeAddress,
    @required this.address,
    // @required this.onChangePaymentMethod,
    @required this.onConfirmOrder,
  });

  @override
  _ConfirmOrderPageState createState() => _ConfirmOrderPageState();
}

class _ConfirmOrderPageState extends State<ConfirmOrderPage> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    // print('Received Address: ${widget.address}');
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String token = snapshot.data.getString(Globals.token);
          return BlocProvider(
            create: (_) => ShoppingCartBloc()..add(LoadingShoppingCart(token)),
            child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
              builder: (context, state) {
                if (state is LoadingShoppingCartState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    ),
                  );
                } else if (state is ShoppingCartLoadedState) {
                  return ListView(
                    children: [
                      // (Your order as follows) title
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'طلبك كالآتي',
                            style: TextStyle(
                              fontSize: _screenUtil.setSp(50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // The items
                      Column(
                        children: List.generate(
                            state.response.items.length,
                            (index) => Padding(
                                  padding:
                                      EdgeInsets.all(_screenUtil.setWidth(30)),
                                  child: PurchasedItem(
                                    title: state.response.items[index].name,
                                    imageUrl:
                                        state.response.items[index].imageUrl,
                                    price: state.response.items[index].price,
                                    quantity:
                                        state.response.items[index].quantity,
                                  ),
                                )),
                      ),

                      // The total price and shipping price
                      Column(
                        children: [
                          // The total price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ج.م',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(50),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _screenUtil.setWidth(20),
                                  ),
                                  Text(
                                    '${state.response.totalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(50),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'الحساب الكلي',
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(50),
                                ),
                              ),
                            ],
                          ),

                          // The shipping price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'ج.م',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(50),
                                    ),
                                  ),
                                  SizedBox(
                                    width: _screenUtil.setWidth(20),
                                  ),
                                  Text(
                                    '${20.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: _screenUtil.setSp(50),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'مصاريف الشحن',
                                style: TextStyle(
                                  fontSize: _screenUtil.setSp(50),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Divider
                      Divider(),

                      // Shipping Address Section
                      //-----------------------------
                      // title
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'عنوان الشحن',
                            style: TextStyle(
                              fontSize: _screenUtil.setSp(50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // the address
                      AddressItem(
                        id: widget.address['id'],
                        buildingNo: widget.address['buildingNo'],
                        city: widget.address['city'] as Map<String, dynamic>,
                        governorate: widget.address['governorate']
                            as Map<String, dynamic>,
                        // country: _addressesList[index]['country'],
                        // zipPostalCode: _addressesList[index]['zipPostalCode'],
                        department: widget.address['department'],
                        floor: widget.address['floor'],
                        street: widget.address['street'],
                        moreDescription: widget.address['moreDescription'],
                      ),

                      // Change address button
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                        child: Stack(
                          children: [
                            Container(
                              color: Color(0xff3573ac),
                              child: ListTile(
                                onTap: () {
                                  widget.onChangeAddress();
                                },
                                title: Text(
                                  'هل تريد تغيير عنوان الشحن؟',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: _screenUtil.setSp(50),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              bottom: 0.0,
                              left: _screenUtil.setWidth(30),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: _screenUtil.setSp(50),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // divider
                      Divider(),

                      // Payment Method Section
                      // -----------------------------
                      // title
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'طريقة الدفع',
                            style: TextStyle(
                              fontSize: _screenUtil.setSp(50),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // payment method
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(30)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'نقدًا عند الاستلام',
                              style: TextStyle(
                                fontSize: _screenUtil.setSp(50),
                              ),
                            ),
                            SizedBox(
                              width: _screenUtil.setWidth(20),
                            ),
                            Image.asset(
                              'assets/cash.png',
                              height: _screenUtil.setWidth(80),
                              width: _screenUtil.setWidth(80),
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                      //   child: Stack(
                      //     children: [
                      //       Container(
                      //         color: Color(0xff3573ac),
                      //         child: ListTile(
                      //           onTap: () {
                      //             widget.onChangePaymentMethod();
                      //           },
                      //           title: Text(
                      //             'هل تريد تغيير طريقة الدفع؟',
                      //             textAlign: TextAlign.center,
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: _screenUtil.setSp(50),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       Positioned(
                      //         top: 0.0,
                      //         bottom: 0.0,
                      //         left: _screenUtil.setWidth(30),
                      //         child: Icon(
                      //           Icons.arrow_back,
                      //           color: Colors.white,
                      //           size: _screenUtil.setSp(50),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      // divider
                      Divider(),

                      // Confirm Order Button
                      Padding(
                        padding: EdgeInsets.all(_screenUtil.setWidth(10)),
                        child: Container(
                          color: Color(0xff3573ac),
                          child: ListTile(
                            onTap: () {
                              widget.onConfirmOrder();
                            },
                            title: Text(
                              'تأكيد الطلب',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: _screenUtil.setSp(50),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
