part of 'shopping_cart_bloc.dart';

abstract class ShoppingCartState extends Equatable {
  const ShoppingCartState();
}

class ShoppingCartInitial extends ShoppingCartState {
  @override
  List<Object> get props => [];
}

class LoadingShoppingCartState extends ShoppingCartState {
  @override
  List<Object> get props => [];
}

class ShoppingCartLoadedState extends ShoppingCartState {
  final ShoppingCartResponse response;

  ShoppingCartLoadedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorLoadingShoppingCartState extends ShoppingCartState {
  final String message;

  ErrorLoadingShoppingCartState(this.message);

  @override
  List<Object> get props => [message];
}

class UpdatingShoppingCartState extends ShoppingCartState {
  @override
  List<Object> get props => [];
}

class ShoppingCartUpdatedState extends ShoppingCartState {
  final ShoppingCartUpdateResponse response;

  ShoppingCartUpdatedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorUpdatingShoppingCartState extends ShoppingCartState {
  final String message;

  ErrorUpdatingShoppingCartState(this.message);

  @override
  List<Object> get props => [message];
}
