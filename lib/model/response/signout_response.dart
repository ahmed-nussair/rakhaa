class SignOutResponse {
  bool result;
  String message;

  SignOutResponse(this.result, this.message);

  factory SignOutResponse.fromJson(Map<String, dynamic> json) =>
      SignOutResponse(
        json['result'] as bool,
        json['message'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'result': result,
        'message': message,
      };
}
