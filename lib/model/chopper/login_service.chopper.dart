// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$LoginService extends LoginService {
  _$LoginService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = LoginService;

  Future<Response<LoginResponse>> login(String username, String password,
      {String deviceId}) {
    final $url = '/api/Login';
    final $body = {
      'username': username,
      'password': password,
      'deviceId': deviceId
    };
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<LoginResponse, LoginResponse>($request);
  }
}
