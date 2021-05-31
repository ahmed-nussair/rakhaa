import 'order_status.dart';
import 'purchased_product.dart';

class Order {
  int id;
  DateTime dateTime;
  OrderStatus status;
  List<PurchasedProduct> items;
  double itemsTotalPrice;

  Order(this.id, this.dateTime, this.status, this.items, this.itemsTotalPrice);

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        json['id'] as int,
        DateTime.parse(json['dateTime']),
        json['status'] == null ? null : OrderStatus.fromJson(json['status']),
        (json['items'] as List)
            ?.map((e) => e == null
                ? null
                : PurchasedProduct.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        (json['itemsTotalPrice'] as num)?.toDouble(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'dataTime': dateTime.toString(),
        'status': status.toJson(),
        'items': items == null
            ? null
            : List.generate(items.length, (index) => items[index].toJson()),
        'itemsTotalPrice': itemsTotalPrice,
      };
}
