part of 'orders_bloc.dart';

abstract class OrdersEvent extends Equatable {
  const OrdersEvent();
}

class LoadingOrders extends OrdersEvent {
  final String token;

  LoadingOrders(this.token);

  @override
  List<Object> get props => [token];
}

class LoadingOrderItem extends OrdersEvent {
  final String token;
  final int orderId;

  LoadingOrderItem(this.token, this.orderId);

  @override
  List<Object> get props => [token, orderId];
}

class AddingOrder extends OrdersEvent {
  final String token;
  final int addressId;
  final int cartId;

  AddingOrder(
      {@required this.token, @required this.addressId, @required this.cartId});

  @override
  List<Object> get props => [token, addressId, cartId];
}
