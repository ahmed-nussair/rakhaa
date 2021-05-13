// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signout_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$SignOutService extends SignOutService {
  _$SignOutService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = SignOutService;

  Future<Response<SignOutResponse>> signOut(Map<String, dynamic> input) {
    final $url = '/api/SignOut';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SignOutResponse, SignOutResponse>($request);
  }
}
