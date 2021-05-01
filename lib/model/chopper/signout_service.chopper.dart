// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signout_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$SignOutService extends SignOutService {
  _$SignOutService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = SignOutService;

  @override
  Future<Response<SignOutResponse>> signOut(Map<String, dynamic> input) {
    final $url = '/api/SignOut';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<SignOutResponse, SignOutResponse>($request);
  }
}
