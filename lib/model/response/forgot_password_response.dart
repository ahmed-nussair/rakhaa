import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  bool result;
  String message;

  ForgotPasswordResponse(this.result, this.message);

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
        json['result'] as bool,
        json['message'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'message': message,
      };
}
