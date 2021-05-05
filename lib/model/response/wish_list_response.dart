import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class WishListResponse {
  bool result;
  String message;

  WishListResponse(
    this.result,
    this.message,
  );

  factory WishListResponse.fromJson(Map<String, dynamic> json) =>
      WishListResponse(
        json['result'] as bool,
        json['message'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'message': message,
      };
}
