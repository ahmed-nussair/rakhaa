import 'package:json_annotation/json_annotation.dart';

import 'product.dart';

@JsonSerializable()
class PurchasedProduct extends Product {
  final int quantity;
  final double totalPrice;

  PurchasedProduct(
      int id,
      int categoryId,
      int subCategoryId,
      String name,
      String imageUrl,
      double price,
      double discount,
      this.quantity,
      this.totalPrice)
      : super(id, categoryId, subCategoryId, name, imageUrl, price, discount);

  factory PurchasedProduct.fromJson(Map<String, dynamic> json) =>
      PurchasedProduct(
        json['id'] as int,
        json['categoryId'] as int,
        json['subCategoryId'] as int,
        json['name'] as String,
        json['imageUrl'] as String,
        json['price'].toDouble(),
        json['discount'].toDouble(),
        json['quantity'] as int,
        json['totalPrice'].toDouble(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'categoryId': categoryId,
        'subCategoryId': subCategoryId,
        'name': name,
        'imageUrl': imageUrl,
        'price': price,
        'discount': discount,
        'quantity': quantity,
        'totalPrice': totalPrice,
      };
}
