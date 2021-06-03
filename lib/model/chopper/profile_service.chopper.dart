// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ProfileService extends ProfileService {
  _$ProfileService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ProfileService;

  Future<Response<ProfileUpdateResponse>> updateProfile(
      String name, String email, String phone, String token,
      {String image}) {
    final $url = '/api/Profile/UpdateProfile';
    final $parts = <PartValue>[
      PartValue<String>('name', name),
      PartValue<String>('email', email),
      PartValue<String>('phone', phone),
      PartValue<String>('token', token),
      PartValueFile<String>('image', image)
    ];
    final $request =
        Request('POST', $url, client.baseUrl, parts: $parts, multipart: true);
    return client.send<ProfileUpdateResponse, ProfileUpdateResponse>($request);
  }

  Future<Response<PasswordUpdateResponse>> updatePassword(
      Map<String, dynamic> input) {
    final $url = '/api/Profile/UpdatePassword';
    final $body = input;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client
        .send<PasswordUpdateResponse, PasswordUpdateResponse>($request);
  }
}
