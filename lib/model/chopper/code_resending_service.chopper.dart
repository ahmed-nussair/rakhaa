// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_resending_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$CodeResendingService extends CodeResendingService {
  _$CodeResendingService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = CodeResendingService;

  Future<Response<CodeResendingResponse>> resend(int userId) {
    final $url = '/api/CodeVerification/Resend';
    final Map<String, dynamic> $params = {'userId': userId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<CodeResendingResponse, CodeResendingResponse>($request);
  }
}
