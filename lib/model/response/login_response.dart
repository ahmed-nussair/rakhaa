import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

@JsonSerializable()
class LoginResponse {
  bool result;
  User data;
  String message;
  String token;

  LoginResponse(
    this.result,
    this.data,
    this.message,
    this.token,
  );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        json['result'] as bool,
        json['data'] == null
            ? null
            : User.fromJson(json['data'] as Map<String, dynamic>),
        json['message'] as String,
        json['token'] as String,
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'result': result,
        'data': data,
        'message': message,
        'token': token,
      };
}
