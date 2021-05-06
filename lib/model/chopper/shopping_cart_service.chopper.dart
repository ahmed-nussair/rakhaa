// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ShoppingCartService extends ShoppingCartService {
  _$ShoppingCartService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ShoppingCartService;

  @override
  Future<Response<ShoppingCartResponse>> getShoppingCart(String token) {
    final $url = '/api/ShoppingCart';
    final $params = <String, dynamic>{'token': token};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<ShoppingCartResponse, ShoppingCartResponse>($request);
  }

  @override
  Future<Response<ShoppingCartUpdateResponse>> updateCart(
      Map<String, dynamic> input) {
    final $url = '/api/ShoppingCart/AddToCart';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<ShoppingCartUpdateResponse, ShoppingCartUpdateResponse>($request);
  }
}
