import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/orders/orders_bloc.dart';
import '../../screen_util.dart';

class ConfirmOrderButton extends StatelessWidget {
  final String token;
  final int addressId;
  final int cartId;
  final Function onConfirmingOrder;
  final Function onOrderConfirmed;
  final ScreenUtil _screenUtil = ScreenUtil();

  ConfirmOrderButton({
    Key key,
    @required this.token,
    @required this.addressId,
    @required this.cartId,
    @required this.onConfirmingOrder,
    @required this.onOrderConfirmed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _screenUtil.init(context);
    return BlocProvider(
      create: (_) => OrdersBloc(),
      child: BlocListener<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state is AddingOrderState) {
            onConfirmingOrder();
          } else if (state is OrderAddedState) {
            onOrderConfirmed();
          }
        },
        child: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            return Container(
              color: Color(0xff3573ac),
              child: ListTile(
                onTap: () {
                  BlocProvider.of<OrdersBloc>(context).add(AddingOrder(
                      token: token, addressId: addressId, cartId: cartId));
                  // widget.onConfirmOrder();
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
            );
          },
        ),
      ),
    );
  }
}
