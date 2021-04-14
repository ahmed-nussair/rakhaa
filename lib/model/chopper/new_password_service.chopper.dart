// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_password_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$NewPasswordService extends NewPasswordService {
  _$NewPasswordService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = NewPasswordService;

  @override
  Future<Response<NewPasswordResponse>> changePassword(
      Map<String, dynamic> input) {
    final $url = '/api/NewPassword';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<NewPasswordResponse, NewPasswordResponse>($request);
  }
}
