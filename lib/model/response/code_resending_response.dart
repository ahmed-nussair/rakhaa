class CodeResendingResponse {
  int userId;
  bool result;
  String code;

  CodeResendingResponse(this.userId, this.result, this.code);

  factory CodeResendingResponse.fromJson(Map<String, dynamic> json) =>
      CodeResendingResponse(
        json['userId'] as int,
        json['result'] as bool,
        json['code'] as String,
      );

  Map<String, dynamic> toJson() =>
      <String, dynamic>{
        'userId': userId,
        'result': true,
        'code': code,
      };
}
