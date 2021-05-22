// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$OrdersService extends OrdersService {
  _$OrdersService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = OrdersService;

  Future<Response<List<Order>>> getOrders(String token) {
    final $url = '/api/Orders';
    final Map<String, dynamic> $params = {'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Order>, Order>($request);
  }

  Future<Response<Order>> getOrder(String token, int orderId) {
    final $url = '/api/Orders/${orderId}';
    final Map<String, dynamic> $params = {'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<Order, Order>($request);
  }

  Future<Response<OrderResponse>> addOrder(
      String token, int addressId, int cartId, String dateTime) {
    final $url = '/api/Orders/AddOrder';
    final $body = {
      'token': token,
      'addressId': addressId,
      'cartId': cartId,
      'dateTime': dateTime
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<OrderResponse, OrderResponse>($request);
  }
}
