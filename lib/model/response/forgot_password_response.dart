class ForgotPasswordResponse {
  int userId;
  bool result;
  String message;

  ForgotPasswordResponse(this.userId, this.result, this.message);

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(
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
