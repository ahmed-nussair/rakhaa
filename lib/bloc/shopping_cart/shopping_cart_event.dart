part of 'shopping_cart_bloc.dart';

abstract class ShoppingCartEvent extends Equatable {
  const ShoppingCartEvent();
}

class LoadingShoppingCart extends ShoppingCartEvent {
  final String token;

  LoadingShoppingCart(this.token);

  @override
  List<Object> get props => [token];
}

class UpdatingShoppingCart extends ShoppingCartEvent {
  final String token;
  final int productId;
  final int quantity;

  UpdatingShoppingCart(this.token, this.productId, this.quantity);

  @override
  List<Object> get props => [token, productId, quantity];
}
