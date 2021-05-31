import 'order.dart';

class OrderResponse {
  bool result;
  String message;
  Order data;

  OrderResponse(this.result, this.message, this.data);

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        json['result'] as bool,
        json['message'] as String,
        json['data'] == null ? null : Order.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'message': message,
        'data': data.toJson(),
      };
}
