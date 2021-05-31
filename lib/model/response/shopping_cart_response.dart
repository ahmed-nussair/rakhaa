import 'purchased_product.dart';

class ShoppingCartResponse {
  int id;
  int userId;
  List<PurchasedProduct> items;
  double totalPrice;

  ShoppingCartResponse(this.id, this.userId, this.items, this.totalPrice);

  factory ShoppingCartResponse.fromJson(Map<String, dynamic> json) =>
      ShoppingCartResponse(
        json['id'] as int,
        json['userId'] as int,
        (json['items'] as List)
            ?.map((e) => e == null
                ? null
                : PurchasedProduct.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        (json['totalPrice'] as num).toDouble(),
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'id': id,
        'userId': userId,
        'items': List.generate(items.length, (index) => items[index].toJson()),
        'totalPrice': totalPrice,
      };
}
