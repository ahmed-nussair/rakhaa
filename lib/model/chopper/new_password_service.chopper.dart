// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_password_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$NewPasswordService extends NewPasswordService {
  _$NewPasswordService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = NewPasswordService;

  Future<Response<NewPasswordResponse>> changePassword(
      Map<String, dynamic> input) {
    final $url = '/api/NewPassword';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<NewPasswordResponse, NewPasswordResponse>($request);
  }
}
