import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ShoppingCartUpdateResponse {
  bool result;
  String message;
  double itemsTotalPrice;

  ShoppingCartUpdateResponse(this.result, this.message, this.itemsTotalPrice);

  factory ShoppingCartUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ShoppingCartUpdateResponse(
          json['result'] as bool,
          json['message'] as String,
          (json['itemsTotalPrice'] as num)?.toDouble());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'message': message,
        'itemsTotalPrice': itemsTotalPrice,
      };
}
