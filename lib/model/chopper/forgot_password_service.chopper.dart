// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ForgotPasswordService extends ForgotPasswordService {
  _$ForgotPasswordService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ForgotPasswordService;

  Future<Response<ForgotPasswordResponse>> send(Map<String, dynamic> input) {
    final $url = '/api/ForgotPassword';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<ForgotPasswordResponse, ForgotPasswordResponse>($request);
  }
}
