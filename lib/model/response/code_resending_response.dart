import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CodeResendingResponse {
  @JsonKey(name: 'user_id')
  int userId;
  bool result;
  String code;

  CodeResendingResponse(this.userId, this.result, this.code);

  factory CodeResendingResponse.fromJson(Map<String, dynamic> json) =>
      CodeResendingResponse(
        json['user_id'] as int,
        json['result'] as bool,
        json['code'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_id': userId,
        'result': true,
        'code': code,
      };
}
