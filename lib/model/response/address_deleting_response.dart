class AddressDeletingResponse {
  int addressId;
  bool result;
  String message;

  AddressDeletingResponse(
    this.addressId,
    this.result,
    this.message,
  );

  factory AddressDeletingResponse.fromJson(Map<String, dynamic> json) =>
      AddressDeletingResponse(
        json['addressId'] as int,
        json['result'] as bool,
        json['message'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'addressId': addressId,
        'result': result,
        'message': message,
      };
}
