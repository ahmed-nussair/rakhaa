// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ShoppingCartService extends ShoppingCartService {
  _$ShoppingCartService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ShoppingCartService;

  Future<Response<ShoppingCartResponse>> getShoppingCart(String token) {
    final $url = '/api/ShoppingCart';
    final Map<String, dynamic> $params = {'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<ShoppingCartResponse, ShoppingCartResponse>($request);
  }

  Future<Response<ShoppingCartUpdateResponse>> updateCart(
      Map<String, dynamic> input) {
    final $url = '/api/ShoppingCart/AddToCart';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<ShoppingCartUpdateResponse, ShoppingCartUpdateResponse>($request);
  }
}
