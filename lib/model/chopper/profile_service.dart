import 'package:chopper/chopper.dart';
import '../response/profile_update_response.dart';
import '../response/password_update_response.dart';

import 'json_to_type_converter.dart';

import 'base_url.dart';

part 'profile_service.chopper.dart';

@ChopperApi(baseUrl: '/api')
abstract class ProfileService extends ChopperService {
  @Post(path: '/Profile/UpdateProfile')
  @multipart
  Future<Response<ProfileUpdateResponse>> updateProfile(
      @Part('name') String name,
      @Part('email') String email,
      @Part('phone') String phone,
      @Part('token') String token,
      {@PartFile('image') String image});

  @Post(path: '/Profile/UpdatePassword')
  @FormUrlEncodedConverter()
  Future<Response<PasswordUpdateResponse>> updatePassword(
      @Body() Map<String, dynamic> input);

  static ProfileService create() {
    var client = ChopperClient(
      baseUrl: baseUrl,
      converter: JsonToTypeConverter({
        ProfileUpdateResponse: (json) => ProfileUpdateResponse.fromJson(json),
        PasswordUpdateResponse: (json) => PasswordUpdateResponse.fromJson(json),
      }),
      services: [
        _$ProfileService(),
      ],
    );
    return _$ProfileService(client);
  }
}
