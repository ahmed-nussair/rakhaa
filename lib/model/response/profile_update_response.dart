import 'user.dart';

class ProfileUpdateResponse {
  bool result;
  String message;
  User data;

  ProfileUpdateResponse(this.result, this.message, this.data);

  factory ProfileUpdateResponse.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponse(
        json['result'] as bool,
        json['message'] as String,
        json['data'] == null ? null : User.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'message': message,
        'data': data.toJson(),
      };
}
