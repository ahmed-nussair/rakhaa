import 'address.dart';

class AddressAddingResponse {
  bool result;
  String message;
  Address data;

  AddressAddingResponse(this.result, this.message, this.data);

  factory AddressAddingResponse.fromJson(Map<String, dynamic> json) =>
      AddressAddingResponse(
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
