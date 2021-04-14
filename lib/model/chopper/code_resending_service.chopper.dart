// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_resending_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$CodeResendingService extends CodeResendingService {
  _$CodeResendingService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = CodeResendingService;

  @override
  Future<Response<CodeResendingResponse>> resend(int userId) {
    final $url = '/api/CodeVerification/Resend';
    final $params = <String, dynamic>{'userId': userId};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<CodeResendingResponse, CodeResendingResponse>($request);
  }
}
