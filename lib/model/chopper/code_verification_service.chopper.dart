// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_verification_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$CodeVerificationService extends CodeVerificationService {
  _$CodeVerificationService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = CodeVerificationService;

  Future<Response<CodeVerificationResponse>> verify(
      Map<String, dynamic> input) {
    final $url = '/api/CodeVerification/Verify';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<CodeVerificationResponse, CodeVerificationResponse>($request);
  }
}
