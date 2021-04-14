import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class NewPasswordResponse {
  @JsonKey(name: 'user_id')
  int userId;
  bool result;
  String message;

  NewPasswordResponse(this.userId, this.result, this.message);

  factory NewPasswordResponse.fromJson(Map<String, dynamic> json) =>
      NewPasswordResponse(
        json['user_id'] as int,
        json['result'] as bool,
        json['message'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'user_id': userId,
        'result': result,
        'message': message,
      };
}
