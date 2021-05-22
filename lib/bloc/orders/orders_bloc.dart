import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../model/chopper/orders_service.dart';
import '../../model/response/order_response.dart';
import '../../model/response/order.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial());

  @override
  Stream<OrdersState> mapEventToState(
    OrdersEvent event,
  ) async* {
    yield OrdersInitial();

    if (event is LoadingOrders) {
      yield LoadingOrdersState();

      var service = OrdersService.create();
      var response = await service.getOrders(event.token);

      if (response.isSuccessful) {
        var ordersResponse = response.body;

        yield OrdersLoadedState(ordersResponse);
      } else {
        yield ErrorLoadingOrdersState('فشل في تحميل البيانات');
      }
    } else if (event is AddingOrder) {
      yield AddingOrderState();

      var dateTime = DateTime.now();

      var service = OrdersService.create();
      var response = await service.addOrder(
          event.token,
          event.addressId,
          event.cartId,
          '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-'
          '${dateTime.day.toString().padLeft(2, '0')} '
          '${dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}:'
          '${dateTime.second.toString().padLeft(2, '0')}');

      if (response.isSuccessful) {
        var addingOrderResponse = response.body;

        yield OrderAddedState(addingOrderResponse);
      } else {
        yield ErrorAddingOrderState('فشل في تحميل البيانات');
      }
    } else if (event is LoadingOrderItem) {
      yield LoadingOrderItemState();

      var service = OrdersService.create();
      var response = await service.getOrder(event.token, event.orderId);
      // print(response.bodyString);
      if (response.isSuccessful) {
        var detailedOrderResponse = response.body;

        yield OrderItemLoadedState(detailedOrderResponse);
      } else {
        yield ErrorLoadingOrderItemState('فشل في تحميل البيانات');
      }
    }
  }
}
