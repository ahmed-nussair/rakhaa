import 'package:json_annotation/json_annotation.dart';

import 'user.dart';

@JsonSerializable()
class SignUpResponse {
  bool result;
  User data;
  String message;

  SignUpResponse(this.result, this.data, this.message);

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        json['result'] as bool,
        json['data'] == null
            ? null
            : User.fromJson(json['data'] as Map<String, dynamic>),
        json['message'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'data': data.toJson(),
        'message': message,
      };
}
