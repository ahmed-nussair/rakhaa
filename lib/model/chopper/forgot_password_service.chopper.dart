// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$ForgotPasswordService extends ForgotPasswordService {
  _$ForgotPasswordService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = ForgotPasswordService;

  @override
  Future<Response<ForgotPasswordResponse>> send(Map<String, dynamic> input) {
    final $url = '/api/ForgotPassword';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<ForgotPasswordResponse, ForgotPasswordResponse>($request);
  }
}
