// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$SignUpService extends SignUpService {
  _$SignUpService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = SignUpService;

  Future<Response<SignUpResponse>> signUp(Map<String, dynamic> input) {
    final $url = '/api/SignUp';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SignUpResponse, SignUpResponse>($request);
  }
}
