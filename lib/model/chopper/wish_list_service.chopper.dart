// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$WishListService extends WishListService {
  _$WishListService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = WishListService;

  @override
  Future<Response<List<Product>>> getWishList(String token, int productId) {
    final $url = '/api/WishList';
    final $params = <String, dynamic>{'token': token, 'productId': productId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Product>, Product>($request);
  }

  @override
  Future<Response<WishListResponse>> addToWishList(Map<String, dynamic> input) {
    final $url = '/api/WishList/AddToWishList';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<WishListResponse, WishListResponse>($request);
  }

  @override
  Future<Response<WishListResponse>> deleteFromWishList(
      Map<String, dynamic> input) {
    final $url = '/api/WishList/DeleteFromWishList';
    final $body = input;
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client.send<WishListResponse, WishListResponse>($request);
  }
}
