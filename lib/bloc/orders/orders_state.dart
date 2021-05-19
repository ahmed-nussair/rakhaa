part of 'orders_bloc.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
}

class OrdersInitial extends OrdersState {
  @override
  List<Object> get props => [];
}

class LoadingOrdersState extends OrdersState {
  @override
  List<Object> get props => [];
}

class OrdersLoadedState extends OrdersState {
  final List<Order> orders;

  OrdersLoadedState(this.orders);

  @override
  List<Object> get props => [orders];
}

class ErrorLoadingOrdersState extends OrdersState {
  final String message;

  ErrorLoadingOrdersState(this.message);

  @override
  List<Object> get props => [message];
}

class AddingOrderState extends OrdersState {
  @override
  List<Object> get props => [];
}

class OrderAddedState extends OrdersState {
  final OrderResponse response;

  OrderAddedState(this.response);

  @override
  List<Object> get props => [response];
}

class ErrorAddingOrderState extends OrdersState {
  final String message;

  ErrorAddingOrderState(this.message);

  @override
  List<Object> get props => [message];
}

class LoadingOrderItemState extends OrdersState {
  @override
  List<Object> get props => [];
}

class OrderItemLoadedState extends OrdersState {
  final Order detailedOrder;

  OrderItemLoadedState(this.detailedOrder);

  @override
  List<Object> get props => [detailedOrder];
}

class ErrorLoadingOrderItemState extends OrdersState {
  final String message;

  ErrorLoadingOrderItemState(this.message);

  @override
  List<Object> get props => [message];
}
