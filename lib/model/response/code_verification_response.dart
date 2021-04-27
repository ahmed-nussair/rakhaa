import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CodeVerificationResponse {
  int userId;
  bool result;
  String message;

  CodeVerificationResponse(this.userId, this.result, this.message);

  factory CodeVerificationResponse.fromJson(Map<String, dynamic> json) =>
      CodeVerificationResponse(
        json['userId'] as int,
        json['result'] as bool,
        json['message'] as String,
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'userId': userId,
        'result': result,
        'message': message,
      };
}
