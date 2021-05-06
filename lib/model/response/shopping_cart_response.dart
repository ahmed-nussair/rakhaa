import 'package:json_annotation/json_annotation.dart';

import 'purchased_product.dart';

@JsonSerializable()
class ShoppingCartResponse {
  int userId;
  List<PurchasedProduct> items;
  double totalPrice;

  ShoppingCartResponse(this.userId, this.items, this.totalPrice);

  factory ShoppingCartResponse.fromJson(Map<String, dynamic> json) =>
      ShoppingCartResponse(
        json['userId'] as int,
        (json['items'] as List)
            ?.map((e) => e == null
                ? null
                : PurchasedProduct.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        (json['totalPrice'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'userId': userId,
        'items': items,
        'totalPrice': totalPrice,
      };
}
