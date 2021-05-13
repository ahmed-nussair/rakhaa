// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_list_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$WishListService extends WishListService {
  _$WishListService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = WishListService;

  Future<Response<List<Product>>> getWishList(String token, int productId) {
    final $url = '/api/WishList';
    final Map<String, dynamic> $params = {
      'token': token,
      'productId': productId
    };
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Product>, Product>($request);
  }

  Future<Response<WishListResponse>> addToWishList(Map<String, dynamic> input) {
    final $url = '/api/WishList/AddToWishList';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<WishListResponse, WishListResponse>($request);
  }

  Future<Response<WishListResponse>> deleteFromWishList(
      Map<String, dynamic> input) {
    final $url = '/api/WishList/DeleteFromWishList';
    final $body = input;
    final $request = Request('DELETE', $url, client.baseUrl, body: $body);
    return client.send<WishListResponse, WishListResponse>($request);
  }
}
