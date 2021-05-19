import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../bloc/shopping_cart/shopping_cart_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../globals.dart' as Globals;
import '../../screen_util.dart';

class ShoppingCartIcon extends StatefulWidget {
  final int id;

  const ShoppingCartIcon({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  _ShoppingCartIconState createState() => _ShoppingCartIconState();
}

class _ShoppingCartIconState extends State<ShoppingCartIcon> {
  final ScreenUtil _screenUtil = ScreenUtil();

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);

    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String token = snapshot.data.getString(Globals.token);
          return BlocProvider(
            create: (_) => ShoppingCartBloc(),
            child: BlocListener<ShoppingCartBloc, ShoppingCartState>(
              listener: (context, state) {
                if (state is ShoppingCartUpdatedState) {
                  Fluttertoast.showToast(
                    msg: 'تم إضافة الصنف لعربة التسوق بنجاح',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: _screenUtil.setSp(50),
                  );
                } else if (state is ErrorUpdatingShoppingCartState) {
                  Fluttertoast.showToast(
                    msg: state.message,
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: _screenUtil.setSp(50),
                  );
                }
              },
              child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
                builder: (context, state) {
                  return state is UpdatingShoppingCartState
                      ? Container(
                          alignment: Alignment.center,
                          width: _screenUtil.setWidth(40),
                          height: _screenUtil.setHeight(40),
                          child: CircularProgressIndicator(),
                        )
                      : GestureDetector(
                          onTap: () {
                            BlocProvider.of<ShoppingCartBloc>(context)
                                .add(UpdatingShoppingCart(token, widget.id, 1));
                          },
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            size: _screenUtil.setSp(70),
                          ),
                        );
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
