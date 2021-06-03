class PasswordUpdateResponse {
  bool result;
  String message;

  PasswordUpdateResponse(this.result, this.message);

  factory PasswordUpdateResponse.fromJson(Map<String, dynamic> json) =>
      PasswordUpdateResponse(
        json['result'] as bool,
        json['message'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'message': message,
      };
}
