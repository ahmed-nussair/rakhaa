import 'address.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AddressUpdatingResponse {
  bool result;
  String message;
  Address data;

  AddressUpdatingResponse(this.result, this.message, this.data);

  factory AddressUpdatingResponse.fromJson(Map<String, dynamic> json) =>
      AddressUpdatingResponse(
        json['result'] as bool,
        json['message'] as String,
        json['data'] == null
            ? null
            : Address.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'message': message,
        'data': data.toJson(),
      };
}
