// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_verification_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CodeVerificationService extends CodeVerificationService {
  _$CodeVerificationService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CodeVerificationService;

  @override
  Future<Response<CodeVerificationResponse>> verify(
      Map<String, dynamic> input) {
    final $url = '/api/CodeVerification/Verify';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<CodeVerificationResponse, CodeVerificationResponse>($request);
  }
}
